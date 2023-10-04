# METADATA
# title: "Verify that Azure Container group is deployed into virtual network"
# description: "Verifying that an Azure Container group is deployed into a virtual network enhances security and control by isolating containerized applications from the public internet, enabling network segmentation, and facilitating controlled connectivity."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group
# custom:
#   id: CB_TFAZR_080
#   severity: LOW
package lib.terraform.CB_TFAZR_080

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_container_group" in block.Labels
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
	resource.Attributes.subnet_ids != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Container group is deployed into virtual network.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Container group should be deployed into virtual network",
		"snippet": block,
	}
}
