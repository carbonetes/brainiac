# METADATA
# title: "Confirm that Service Fabric utilizes all three available levels of protection"
# description: "Confirm that Service Fabric is configured to employ the three available levels of protection. This comprehensive approach enhances the security and resilience of the system, safeguarding it from potential threats and vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_fabric_cluster
# custom:
#   id: CB_TFAZR_101
#   severity: LOW
package lib.terraform.CB_TFAZR_101

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
	some innerBlock in block.Blocks
    innerBlock.Type == "fabric_settings"
	innerBlock.Attributes.name == "Security"
    innerBlock.Attributes.parameters.name == "ClusterProtectionLevel"
    innerBlock.Attributes.parameters.value == "EncryptAndSign"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Service Fabric utilizes all three available levels of protection.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Service Fabric must utilize all three available levels of protection.",
		"snippet": block,
	}
}