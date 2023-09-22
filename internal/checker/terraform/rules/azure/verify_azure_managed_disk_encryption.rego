# METADATA
# title: "Verify Azure managed disk has encryption enabled"
# description: "To enhance security and meet regulatory compliance requirements, it's important to verify that encryption is enabled for these managed disks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
# custom:
#   id: CB_TFAZR_042
#   severity: HIGH
package lib.terraform.CB_TFAZR_042

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_managed_disk" in block.Labels
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
	some block in resource.Blocks
	block.Type == "encryption_settings"
	block.Attributes.enabled == true
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.disk_encryption_set_id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure managed disk has encryption enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure managed disk should have encryption enabled",
		"snippet": block,
	}
}
