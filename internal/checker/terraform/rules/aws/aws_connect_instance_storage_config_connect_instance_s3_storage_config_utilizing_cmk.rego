# METADATA
# title: "Verify that the S3 Storage Config of the Connect Instance utilizes a Customer Managed Key (CMK) for encryption"
# description: "Validate that the Connect Instance's S3 Storage Config is configured to use Customer Managed Keys (CMK) for encryption, ensuring compliance with security best practices."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/connect_instance_storage_config
# custom:
#   id: CB_TFAWS_245
#   severity: HIGH
package lib.terraform.CB_TFAWS_245
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_connect_instance_storage_config"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
    isvalid(resource)
    some type in resource.Blocks
    type.Type == "storage_config"
    some block in type.Blocks
    block.Type == "s3_config"
    some nested_block in block.Blocks
    nested_block.Type == "encryption_config"
    has_attribute(nested_block.Attributes, "key_id")
    nested_block.Attributes.key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "CMK is being utilized by Connect Instance S3 Storage Config.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "CMK must be utilized by Connect Instance S3 Storage Config.",
                "snippet": block }
} 