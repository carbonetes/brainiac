# METADATA
# title: "Verify AWS Config recorder is enabled to record all supported resources"
# description: "This policy is designed to ensure comprehensive monitoring and compliance of Amazon Web Services (AWS) resources by verifying that AWS Config recorder is enabled to record all supported resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder.html
# custom:
#   id: CB_TFAWS_341
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_341

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_config_configuration_recorder"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getconfigrecorderlabel contains label if {
	some block in input
	block.Type == "resource"
	"aws_config_configuration_recorder" in block.Labels
	label := concat(".", block.Labels)
}

is_config_recorder_status_true if {
	some block in input
	block.Type == "resource"
	"aws_config_configuration_recorder_status" in block.Labels
	some label in getconfigrecorderlabel
	contains(block.Attributes.name, label)
	block.Attributes.is_enabled == true
}

pass contains block if {
	some block in input
	isvalid(block)
	some inner in block.Blocks
	inner.Type == "recording_group"
	inner.Attributes.include_global_resource_types != false
	is_config_recorder_status_true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS Config recorder is enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS Config recorder is disabled.",
		"snippet": block,
	}
}
