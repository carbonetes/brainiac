# METADATA
# title: "Verify that ACR prevents unauthorized image pulling"
# description: "Enhance container image security by restricting ACR image pulling to authorized users only."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
# custom:
#   id: CB_TFAZR_141
#   severity: LOW
package lib.terraform.CB_TFAZR_141

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
	resource.Attributes.anonymous_pull_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "ACR does not allow unauthorized image pulling.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "ACR must not allow unauthorized image pulling.",
		"snippet": block,
	}
}
