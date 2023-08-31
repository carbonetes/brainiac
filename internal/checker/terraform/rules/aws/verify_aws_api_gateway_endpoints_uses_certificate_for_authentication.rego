# METADATA
# title: "Verify AWS API Gateway endpoints uses client certificate authentication"
# description: "This policy is designed to ensure the secure authentication of Amazon Web Services (AWS) API Gateway endpoints by verifying that client certificate authentication is implemented."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage
# custom:
#   id: CB_TFAWS_368
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_368

supportedResources := ["aws_api_gateway_stage", "aws_apigatewayv2_stage"]

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == supportedResources[_]
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.client_certificate_id != ""
}

getApigatewayv2ApiLabel[label] {
	block := input[_]
	block.Type == "resource"
	block.Labels[_] == "aws_apigatewayv2_api"
	label := concat(".", block.Labels)
	block.Attributes.protocol_type != "WEBSOCKET"
}


isApigatewayv2StageExists {
	block := input[_]
	block.Type == "resource"
	block.Labels[_] == "aws_apigatewayv2_stage"
	contains(block.Attributes.api_id, getApigatewayv2ApiLabel[_])
}


pass[block] {
	block := input[_]
	isvalid(block)
	isApigatewayv2StageExists
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "AWS API Gateway endpoints are using client certificate authentication.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "AWS API Gateway endpoints are not using client certificate authentication.",
		"snippet": block,
	}
}
