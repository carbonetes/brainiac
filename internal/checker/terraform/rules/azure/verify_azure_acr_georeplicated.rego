# METADATA
# title: "Verify geo-replicated container registries to match multi-region container deployments."
# description: "This policy is designed to enhance the reliability and consistency of multi-region container deployments by verifying that geo-replicated container registries match the regions used for container deployments."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
# custom:
#   id: CB_TFAZR_182
#   severity: "MEDIUM"
package lib.terraform.CB_TFAZR_182

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

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.sku == "Premium"
	some innerBlock in block.Blocks
	innerBlock.Type == "georeplications"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Geo-replicated container registries match multi-region deployments.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Geo-replicated container registries do not match the regions used for container deployments.",
		"snippet": block,
	}
}