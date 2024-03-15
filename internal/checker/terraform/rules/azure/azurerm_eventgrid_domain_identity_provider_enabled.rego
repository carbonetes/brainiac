# METADATA
# title: "Enable Managed Identity Provider for Azure Event Grid Domain"
# description: "This policy ensures that the managed identity provider is enabled for Azure Event Grid Domains. Enabling the managed identity provider enhances security and provides secure access control for the domain."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain
# custom:
#   id: CB_TFAZR_190
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_190

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_eventgrid_domain" in block.Labels
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
    some block in resource.Blocks
    block.Type == "identity"
    block.Attributes.type != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Managed identity provider is enabled for Azure Event Grid Domain, enhancing security and access control.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Enable the managed identity provider for Azure Event Grid Domain to enhance security and access control for the domain.",
		"snippet": block, 
    }
}
