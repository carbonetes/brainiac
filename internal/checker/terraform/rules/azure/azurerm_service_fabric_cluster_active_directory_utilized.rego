# METADATA
# title: "Verify that Service Fabric employs Active Directory for authentication purposes"
# description: "Confirm that Service Fabric leverages Active Directory for authentication, bolstering security by ensuring secure and authenticated access to its resources. This integration enhances identity management and access control within the Service Fabric ecosystem, contributing to a more secure and compliant environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_fabric_cluster
# custom:
#   id: CB_TFAZR_108
#   severity: LOW
package lib.terraform.CB_TFAZR_108

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_service_fabric_cluster" in block.Labels
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
    some inner_block in block.Blocks
	 "tenant_id" in object.keys(inner_block.Attributes)
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Service Fabric utilizes Active Directory for authentication purposes.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Service Fabric must utilize Active Directory for authentication purposes.",
		"snippet": block,
	}
}