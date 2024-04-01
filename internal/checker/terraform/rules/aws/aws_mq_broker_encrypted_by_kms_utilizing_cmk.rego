# METADATA
# title: "A customer managed Key (CMK) should be used to encrypt the MQ broker"
# description: "This quick test verifies that the MQ broker encrypts its contents with AWS key management - KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rgeraskin/aws3/latest/docs/resources/mq_broker
# custom:
#   id: CB_TFAWS_233
#   severity: LOW
package lib.terraform.CB_TFAWS_233
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_mq_broker"
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
    some block in resource.Blocks
    block.Type == "encryption_options"  
    has_attribute(block.Attributes, "kms_key_id")
    block.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Customer Managed Key (CMK) is used to encrypt the MQ broker.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Customer Managed Key (CMK) must be used to encrypt the MQ broker.",
                "snippet": block }
} 