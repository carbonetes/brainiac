# METADATA
# title: "Verify FTP deployments are disabled"
# description: "This policy is designed to enhance security by verifying that FTP (File Transfer Protocol) deployments are disabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_048
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_048

import future.keywords.in

supportedResources := ["azurerm_app_service", "azurerm_linux_web_app", "azurerm_windows_web_app"]

isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	label in supportedResources
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	some innerBlock in block.Blocks
	innerBlock.Type == "site_config"
	validValues := ["Disabled", "FtpsOnly"]
	innerBlock.Attributes.ftps_state in validValues
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "FTP deployments are disabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "FTP deployments are not disabled.",
		"snippet": block,
	}
}