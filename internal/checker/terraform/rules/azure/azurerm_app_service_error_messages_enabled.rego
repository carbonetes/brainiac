# METADATA
# title: "Make certain that the App service is configured to activate detailed error messages"
# description: "Verify that detailed error messages are activated within your App service configuration, confirming that comprehensive diagnostic information is accessible when issues arise. This setting facilitates efficient troubleshooting and resolution of errors, contributing to the reliability and performance of your application."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app
# custom:
#   id: CB_TFAZR_067
#   severity: LOW
package lib.terraform.CB_TFAZR_067

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
    innerBlock.Type == "logs"
	innerBlock.Attributes.detailed_error_messages_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The App service is configured to activate detailed error messages.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The App service must be configured to activate detailed error messages.",
		"snippet": block,
	}
}