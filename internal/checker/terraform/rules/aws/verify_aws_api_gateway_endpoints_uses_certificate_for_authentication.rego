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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_api_gateway_stage", "aws_apigatewayv2_stage"]
	label in supported_resources
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains block if {
	some block in input
	isvalid(block)
	block.Attributes.client_certificate_id != ""
}

getapigatewayv2apilabel contains label if {
	some block in input
	block.Type == "resource"
	"aws_apigatewayv2_api" in block.Labels
	label := concat(".", block.Labels)
	block.Attributes.protocol_type != "WEBSOCKET"
}

is_apigateway_v2_stage_exists if {
	some block in input
	block.Type == "resource"
	"aws_apigatewayv2_stage" in block.Labels
	some label in getapigatewayv2apilabel
	contains(block.Attributes.api_id, label)
}

pass contains block if {
	some block in input
	isvalid(block)
	is_apigateway_v2_stage_exists
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS API Gateway endpoints are using client certificate authentication.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS API Gateway endpoints are not using client certificate authentication.",
		"snippet": block,
	}
}
