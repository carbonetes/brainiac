# METADATA
# title: "Verify Wechat Configuration for Rancher2 Notifier"
# description: "This policy ensures that Wechat Configuration for Rancher2 Notifier are properly configured with valid and required attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/notifier
# custom:
#   id: CB_TFRAN_165
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_165

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
	not validate_wechat(block)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

validate_wechat(block) {
	some innerblock in block.Blocks
	innerblock.Type == "wechat_config"
	innerblock.Attributes.agent != ""
    innerblock.Attributes.corp != ""
    innerblock.Attributes.default_recipient != ""
    innerblock.Attributes.secret != ""
}

passed[result] {
	some block in pass
	result := {
		"message": "Wechat Configuration for Rancher2 Notifier is properly configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Wechat Configuration for Rancher2 Notifier has invalid or missing attributes. Check and fix the configuration.",
		"snippet": block,
	}
}
