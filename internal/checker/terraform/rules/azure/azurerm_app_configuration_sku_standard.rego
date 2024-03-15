# METADATA
# title: "Enforce Standard SKU for App Configuration"
# description: "This policy ensures that the Standard SKU is used for Azure App Configuration, providing advanced features and reliability."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration
# custom:
#   id: CB_TFAZR_183
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_183

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
	resource.Attributes.sku == "standard"
}


fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
     	"message": "Azure App Configuration uses the Standard SKU, ensuring advanced features and reliability.",
		"snippet": block,
    }
}

failed[result] {
	some block in fail
	result := {
    	"message": "Azure App Configuration should be configured with the Standard SKU to access advanced features and enhance reliability.",
		"snippet": block,
    }
}
