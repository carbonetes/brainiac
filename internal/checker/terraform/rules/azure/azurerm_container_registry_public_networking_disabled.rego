# METADATA
# title: "Verify that ACR is configured to deactivate public networking"
# description: "Confirm that ACR is configured to deactivate public networking, enhancing the security of your Azure Container Registry by restricting access from the public internet."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_registry
# custom:
#   id: CB_TFAZR_155
#   severity: LOW
package lib.terraform.CB_TFAZR_155

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_container_registry" in block.Labels
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
	resource.Attributes.public_network_access_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "ACR is configured to deactivate public networking.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "ACR must be configured to deactivate public networking.",
		"snippet": block,
	}
}
