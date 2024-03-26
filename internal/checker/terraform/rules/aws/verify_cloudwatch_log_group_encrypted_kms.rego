# METADATA
# title: "Verify that CloudWatch Log Group is encrypted by KMS"
# description: "By encrypting the log group with KMS, you add an additional layer of protection to prevent unauthorized access to the logs."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group.html
# custom:
#   id: CB_TFAWS_134
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_134
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_cloudwatch_log_group"
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
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_cloudwatch_log_group' 'kms_key_id' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_cloudwatch_log_group' 'kms_key_id' should be set.",
                "snippet": block }
}