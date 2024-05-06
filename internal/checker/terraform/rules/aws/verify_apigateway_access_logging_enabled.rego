# METADATA
# title: "Verify API Gateway has Access Logging enabled"
# description: "Enabling access logging for an API Gateway provides valuable insights into the requests and responses made to your API."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage
# custom:
#   id: CB_TFAWS_085
#   severity: LOW
package lib.terraform.CB_TFAWS_085

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_api_gateway_stage", "aws_apigatewayv2_stage"]
	label in supportedresource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

has_attribute(key, value) if {
	value in object.keys(key)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "access_log_settings"
	has_attribute(block.Attributes, "destination_arn")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'API Gateway' 'access_log_settings' destination_arn is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'API Gateway ' 'access_log_settings' destination_arn should be set properly.",
		"snippet": block,
	}
}