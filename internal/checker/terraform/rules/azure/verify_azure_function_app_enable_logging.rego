# METADATA
# title: "Verify function app builtin logging is enabled"
# description: "This policy is designed to enhance the monitoring and security of Azure Function Apps by verifying that builtin logging is enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/function_app_slot
# custom:
#   id: CB_TFAZR_174
#   severity: LOW
package lib.terraform.CB_TFAZR_174

import future.keywords.in

supportedResources := ["azurerm_function_app", "azurerm_function_app_slot"]

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
	block.Attributes.enable_builtin_logging == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Function App has built-in logging enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Function App does not have built-in logging enabled.",
		"snippet": block,
	}
}