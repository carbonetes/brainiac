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

supportedResources := ["azurerm_automation_variable_bool", "azurerm_automation_variable_datetime", "azurerm_automation_variable_int", "azurerm_automation_variable_string"]

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == supportedResources[_]
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.encrypted == true
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "Automation account variables are encrypted.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "Automation account variables are not encrypted.",
		"snippet": block,
	}
}
