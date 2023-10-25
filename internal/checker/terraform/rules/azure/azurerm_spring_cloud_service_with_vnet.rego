# METADATA
# title: "Verify that Azure Spring Cloud is properly integrated with a Virtual Network (VNet) for secure and isolated network communication"
# description: "This policy checks if Azure Spring Cloud is correctly configured to utilize a Virtual Network (VNet) for enhanced network security and isolation."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/spring_cloud_service
# custom:
#   id: CB_TFAZR_219
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_219

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_spring_cloud_service" in resource.Labels
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
	resource.Attributes.sku_name != "B0"
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "network"
	block.Attribute.service_runtime_subnet_id != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Spring Cloud is configured with a Virtual Network, ensuring enhanced network security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Spring Cloud is not configured with a Virtual Network. This may result in decreased network security and isolation.",
		"snippet": block,
	}
}
