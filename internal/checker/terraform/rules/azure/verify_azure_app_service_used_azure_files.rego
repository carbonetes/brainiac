# METADATA
# title: "Verify that app services use Azure Files"
# description: "This policy is designed to enhance the storage efficiency and data management of Azure App Services by verifying that Azure Files is used as the storage solution."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_094
#   severity: LOW
package lib.terraform.CB_TFAZR_094

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
	innerBlock.Type == "storage_account"
	innerBlock.Attributes.type == "AzureFiles"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Files is used as the storage solution for the App Service.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Files is not used as the storage solution for the App Service.",
		"snippet": block,
	}
}