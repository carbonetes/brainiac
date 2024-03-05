# METADATA
# title: "Verify that the ACR admin account is deactivated"
# description: "Verify that the ACR admin account is deactivated to bolster Azure Container Registry security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
# custom:
#   id: CB_TFAZR_131
#   severity: LOW
package lib.terraform.CB_TFAZR_131

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
	resource.Attributes.admin_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The ACR admin account is deactivated.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The ACR admin account is activated, it must be deactivated.",
		"snippet": block,
	}
}
