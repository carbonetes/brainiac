# METADATA
# title: "Ensures that a Customer Managed Key (CMK) should be used by KMS to encrypt Kinesis Video Stream"
# description: "This quick test verifies that Kinesis Video Stream encrypts its content using AWS key management - KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_video_stream
# custom:
#   id: CB_TFAWS_168
#   severity: HIGH
package lib.terraform.CB_TFAWS_168
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_kinesis_video_stream"
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
    has_attribute(resource.Attributes, "kms_key_id")
    resource.Attributes.kms_key_id != ""
}


fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Customer Managed Key (CMK) is used by KMS to encrypt Kinesis Video Stream.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Customer Managed Key (CMK) must be used by KMS to encrypt Kinesis Video Stream.",
                "snippet": block }
} 