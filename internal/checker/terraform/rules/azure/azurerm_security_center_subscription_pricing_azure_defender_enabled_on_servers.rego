# METADATA
# title: "Confirm that Servers have Azure Defender enabled"
# description: "Verify that Azure Defender is activated to enhance security on your Servers, offering protection against potential threats and vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing
# custom:
#   id: CB_TFAZR_097
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_097

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_security_center_subscription_pricing" in block.Labels
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
	block.Attributes.resource_type != "VirtualMachines"
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.tier == "Standard"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Servers have Azure Defender enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Servers have Azure Defender disabled, it must be enabled.",
		"snippet": block,
	}
}
