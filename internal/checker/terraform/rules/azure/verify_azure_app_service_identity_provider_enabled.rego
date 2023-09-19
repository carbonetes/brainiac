# METADATA
# title: "Verify that Managed identity provider is enabled for app services"
# description: "This policy is designed to enhance the security and access management of Azure App Services by verifying that the Managed Identity provider is enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
# custom:
#   id: CB_TFAZR_033
#   severity: LOW
package lib.terraform.CB_TFAZR_033

supportedResources := ["azurerm_app_service", "azurerm_linux_web_app", "azurerm_windows_web_app"]

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
	innerBlock := block.Blocks[_]
	innerBlock.Type == "identity"
	innerBlock.Attributes.type != ""
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "The Managed Identity provider is enabled for the App Service.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "The Managed Identity provider is not enabled for the App Service.",
		"snippet": block,
	}
}
