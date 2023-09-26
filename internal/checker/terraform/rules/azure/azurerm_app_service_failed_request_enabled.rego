# METADATA
# title: "Confirm that the App service has activated failed request tracing"
# description: "Verify that failed request tracing is enabled for your App service, offering valuable insights into problematic HTTP requests and enhancing your troubleshooting capabilities. This feature confirms that issues are promptly identified and resolved, contributing to a more resilient and reliable web application environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app
# custom:
#   id: CB_TFAZR_064
#   severity: LOW
package lib.terraform.CB_TFAZR_064

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
	innerBlock.Attributes.failed_request_tracing_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The App service has activated failed request tracing.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The App service must activate failed request tracing.",
		"snippet": block,
	}
}