# METADATA
# title: "Verify that AWS Lambda function is configured for a Dead Letter Queue(DLQ)"
# description: "By configuring a DLQ, any failed or unprocessed events are captured and stored separately, preventing data loss."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_106
#   severity: LOW
package lib.terraform.CB_TFAWS_106

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_lambda_function"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "dead_letter_config"
    has_attribute(resource.Blocks[_].Attributes, "target_arn")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_lambda_function' 'dead_letter_config' target_arn is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_lambda_function' 'dead_letter_config' target_arn should be set.",
                "snippet": block }
} 