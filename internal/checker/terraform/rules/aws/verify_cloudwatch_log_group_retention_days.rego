# METADATA
# title: "Verify that CloudWatch Log Group specifies retention days"
# description: "By setting retention days for a log group, you can control how long log events are retained before they expire and are automatically deleted."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
# custom:
#   id: CB_TFAWS_066
#   severity: LOW
package lib.terraform.CB_TFAWS_066

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudwatch_log_group"
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
	has_attribute(resource.Attributes, "retention_in_days")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_cloudwatch_log_group' 'retention_in_days' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_cloudwatch_log_group' 'retention_in_days' should be set.",
		"snippet": block,
	}
}