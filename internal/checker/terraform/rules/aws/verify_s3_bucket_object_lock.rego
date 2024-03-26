# METADATA
# title: "Verify that S3 bucket has lock configuration enabled by default"
# description: "By enabling the lock configuration on an S3 bucket, it ensures that critical objects stored within the bucket are protected from accidental or malicious deletion or modification, providing an added layer of data integrity and compliance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#object_lock_configuration
# custom:
#   id: CB_TFAWS_147
#   severity: LOW
package lib.terraform.CB_TFAWS_147
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_s3_bucket"
    some res in block.Blocks
    res.Type == "object_lock_configuration"
    has_attribute(res.Attributes, "object_lock_enabled")
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
    resource.Blocks[_].Attributes.object_lock_enabled == "Enabled"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_s3_bucket' for 'object_lock_configuration' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_s3_bucket' for 'object_lock_configuration' should be set.",
                "snippet": block }
}