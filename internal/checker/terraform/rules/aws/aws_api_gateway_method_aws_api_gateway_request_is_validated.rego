# METADATA
# title: "Confirm proper validation of AWS API gateway requests"
# description: "Verify the implementation of thorough validation for incoming requests within AWS API gateways. This security measure fortifies the prevention of unauthorized or malicious requests."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method.html
# custom:
#   id: CB_TFAWS_356
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_356

import future.keywords.if

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_api_gateway_method"
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
    resource.Attributes.request_validator_id
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "The AWS API gateway requests has proper validation.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "The AWS API gateway requests must have proper validation.",
                "snippet": block }
} 