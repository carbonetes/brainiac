# METADATA
# title: "Verify API GatewayV2 routes specify an authorization type"
# description: "It ensures only authorized users or services can interact with the API, protecting against unauthorized access and potential security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.9.0/docs/resources/apigatewayv2_route#authorization_type
# custom:
#   id: CB_TFAWS_292
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_292

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_apigatewayv2_route"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    expectedValue := ["AWS_IAM", "CUSTOM", "JWT"]
    resource.Attributes.authorization_type == expectedValue[_]
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "API GatewayV2 routes specify an authorization type.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "API GatewayV2 routes must specify an authorization type.",
                "snippet": block }
}
