# METADATA
# title: "Verify vulnerability scanning for container images"
# description: "This policy is designed to enhance the security and risk mitigation of containerized applications by verifying that vulnerability scanning is performed on container images."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
# custom:
#   id: CB_TFAZR_181
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_181

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
	validSkuValue := ["Standard", "Premium"]
	some block.Attributes.sku in validSkuValue
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Vulnerability scanning is enabled for container images in Azure Container Registry (ACR).",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Vulnerability scanning is not enabled for container images in Azure Container Registry (ACR).",
		"snippet": block,
	}
}
