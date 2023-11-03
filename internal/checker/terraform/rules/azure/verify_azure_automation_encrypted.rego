# METADATA
# title: "Verify that Automation account variables are encrypted"
# description: "This policy is designed to enhance the security and data protection of Azure Automation accounts by verifying that variables within the account are properly encrypted."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/automation_variable_bool
# custom:
#   id: CB_TFAZR_038
#   severity: LOW
package lib.terraform.CB_TFAZR_038

import future.keywords.in

isvalid(block) {
	supported_resources := ["azurerm_automation_variable_bool", 
							"azurerm_automation_variable_datetime", 
							"azurerm_automation_variable_int", 
							"azurerm_automation_variable_string"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
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
	block.Attributes.encrypted == true
}

fail[block] {
    some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
    some block in pass
	result := {
		"message": "Automation account variables are encrypted.",
		"snippet": block,
	}
}

failed[result] {
    some block in fail
	result := {
		"message": "Automation account variables are not encrypted.",
		"snippet": block,
	}
}