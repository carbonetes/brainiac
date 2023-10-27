# METADATA
# title: "Verify that ACR uses signed/trusted images"
# description: "This policy is designed to enhance the security and trustworthiness of container images stored in Azure Container Registry (ACR) by verifying that only signed or trusted images are used."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
# custom:
#   id: CB_TFAZR_180
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_180

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
	some innerBlock in block.Blocks
	innerBlock.Type == "trust_policy"
	innerBlock.Attributes.enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Container Registry (ACR) enforces the use of signed/trusted images.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Container Registry (ACR) does not enforce the use of signed/trusted images.",
		"snippet": block,
	}
}