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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudwatch_log_group"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "kms_key_id")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudwatch_log_group' 'kms_key_id' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudwatch_log_group' 'kms_key_id' should be set.",
                "snippet": block }
} 