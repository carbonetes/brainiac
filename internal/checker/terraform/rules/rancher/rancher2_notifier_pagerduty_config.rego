# METADATA
# title: "Verify Pagerduty Configuration for Rancher2 Notifier"
# description: "This policy ensures that Pagerduty Configuration for Rancher2 Notifier are properly configured with valid and required attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/notifier
# custom:
#   id: CB_TFRAN_161
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_161

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_notifier" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
	some block in input
	isvalid(block)
	not validate_pagerduty(block)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

validate_pagerduty(block) {
	some innerblock in block.Blocks
	innerblock.Type == "pagerduty_config"
	innerblock.Attributes.service_key != ""
}

passed[result] {
	some block in pass
	result := {
		"message": "Pagerduty Configuration for Rancher2 Notifier is properly configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Pagerduty Configuration for Rancher2 Notifier has invalid or missing attributes. Check and fix the configuration.",
		"snippet": block,
	}
}
