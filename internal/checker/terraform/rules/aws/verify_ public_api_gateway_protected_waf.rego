# METADATA
# title: "Verify public API gateway are protected by WAF"
# description: "WAF serves as a security layer that safeguards web applications from various types of online threats, including malicious attacks and unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment.html
# custom:
#   id: CB_TFAWS_331
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_331

import rego.v1

isGatewayStage(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_api_gateway_stage"
}

isGatewayRes(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_api_gateway_rest_api"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getgatewayrestlabel contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_api_gateway_rest_api" in resource.Labels
	label := concat(".", resource.Labels)
}

rest_private if {
	some resource in input
	isGatewayRes(resource)
	some block in resource.Blocks
	block.Type == "endpoint_configuration"
	"PRIVATE" in block.Attributes.types
}

fail contains resource if {
	some resource in input
	isGatewayStage(resource)
	some label in getgatewayrestlabel
	contains(resource.Attributes.rest_api_id, label)
	not rest_private
}

pass contains block if {
	some block in input
	isGatewayStage(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Public API gateway are protected by WAF.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Public API gateway should be protected by WAF.",
		"snippet": block,
	}
}
