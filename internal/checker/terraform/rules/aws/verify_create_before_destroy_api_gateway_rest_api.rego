# METADATA
# title: "Verify Create before destroy for API GATEWAY"
# description: "By verifying Create before destroy, you can avoid service interruptions, prevent data loss, and maintain a consistent user experience."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api
# custom:
#   id: CB_TFAWS_226
#   severity: LOW
package lib.terraform.CB_TFAWS_226

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_api_gateway_rest_api"
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
    resource.Blocks[_].Type == "lifecycle"
    resource.Blocks[_].Attributes.create_before_destroy == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_api_gateway_rest_api' lifecycle is set properly",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_api_gateway_rest_api' lifecycle 'create_before_destroy' should be set to true",
                "snippet": block }
} 