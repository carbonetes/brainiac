# METADATA
# title: "Verify that ELBv2 (Application/Network) has access logging enabled"
# description: "By enabling access logging for the ELBv2 (Application/Network), detailed records of incoming requests and traffic patterns are captured, providing crucial insights for troubleshooting, security analysis, and performance optimization."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb#access_logs
# custom:
#   id: CB_TFAWS_098
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_098

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_lb", "aws_alb"]
	label in supportedresource
}

has_attribute(key, value) if {
	value in object.keys(key)
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
	some blocks in resource.Blocks
	blocks.Type == "access_logs"
	has_attribute(blocks.Attributes, "enabled")
	blocks.Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_lb' or 'aws_alb' for 'access_logs' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_lb' or 'aws_alb' for 'access_logs' should be set.",
		"snippet": block,
	}
}