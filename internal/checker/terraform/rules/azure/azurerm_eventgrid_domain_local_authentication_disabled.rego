# METADATA
# title: "Disable Local Authentication for Azure Event Grid Domain"
# description: "This policy ensures that local authentication is disabled for Azure Event Grid Domains. Disabling local authentication enhances security by restricting access to trusted networks and managed identity providers."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain
# custom:
#   id: CB_TFAZR_191
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_191

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
	resource.Attributes.local_auth_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Local authentication is disabled for Azure Event Grid Domain, enhancing security by restricting access to trusted networks and managed identity providers.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Disable local authentication for Azure Event Grid Domain to enhance security and restrict access to trusted networks and managed identity providers.",
		"snippet": block, 
    }
}
