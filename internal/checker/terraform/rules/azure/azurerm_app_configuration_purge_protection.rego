# METADATA
# title: "Enable Purge Protection in App Configuration"
# description: "Ensure that purge protection is enabled in App Configuration to prevent accidental or malicious data deletion."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration
# custom:
#   id: CB_TFAZR_166
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_166

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_app_configuration" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.purge_protection_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Purge protection is enabled in App Configuration, preventing accidental or malicious data deletion.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Purge protection must be enabled in App Configuration to prevent accidental or malicious data deletion.",
		"snippet": block,
	}
}
