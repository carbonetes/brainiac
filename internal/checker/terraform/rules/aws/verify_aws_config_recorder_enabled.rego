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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_config_configuration_recorder"
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

getConfigRecorderLabel[label] {
	block := input[_]
	block.Type == "resource"
	block.Labels[_] == "aws_config_configuration_recorder"
	label := concat(".", block.Labels)
}

isConfigRecorderStatusTrue {
	block := input[_]
	block.Type == "resource"
	block.Labels[_] == "aws_config_configuration_recorder_status"
	contains(block.Attributes.name, getConfigRecorderLabel[_])
	block.Attributes.is_enabled == true
}

pass[block] {
	block := input[_]
	isvalid(block)
	innerBlock := block.Blocks[_]
	innerBlock.Type == "recording_group"
	innerBlock.Attributes.include_global_resource_types != false
	isConfigRecorderStatusTrue
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "AWS Config recorder is enabled.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "AWS Config recorder is disabled.",
		"snippet": block,
	}
}
