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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_apigatewayv2_route"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	expected_values := ["AWS_IAM", "CUSTOM", "JWT"]
	resource.Attributes.authorization_type in expected_values
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "API GatewayV2 routes specify an authorization type.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "API GatewayV2 routes must specify an authorization type.",
		"snippet": block,
	}
}
