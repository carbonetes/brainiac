# METADATA
# title: "Verify that the API Gateway stage has the appropriate logging level specified"
# description: "Setting the right logging level for your API Gateway stages is highly recommended because it enables you to record and examine specific details about the requests and replies processed by your API."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings
# custom:
#   id: CB_TFAWS_326
#   severity: LOW
package lib.terraform.CB_TFAWS_326

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_api_gateway_method_settings"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getapigatewaystagelabel contains label if {
	some resource in input
	resource.Type == "resource"
	some label_resource in resource.Labels
	label_resource == "aws_api_gateway_stage"
	label := concat(".", resource.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	some label_resource in resource.Labels
	label_resource == "aws_api_gateway_method_settings"
	some gateway_stage_label in getapigatewaystagelabel
	startswith(resource.Attributes.stage_name, gateway_stage_label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	expected_values := ["ERROR", "INFO"]
	some block in resource.Blocks
	block.Type == "settings"
	block.Attributes.logging_level in expected_values
	block.Attributes.metrics_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "API Gateway stage has the appropriate logging level specified.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "API Gateway stage must have the appropriate logging level specified.",
		"snippet": block,
	}
}
