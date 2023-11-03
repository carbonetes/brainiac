# METADATA
# title: "Verify that managed disks use a specific set of disk encryption sets for the customer-managed key encryption"
# description: "It enables precise control over data protection, meets regulatory requirements, and reduces security risks by enforcing encryption standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk
# custom:
#   id: CB_TFAZR_072
#   severity: LOW
package lib.terraform.CB_TFAZR_072

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
		"message": "'azurerm_managed_disk' customer-managed key encryption is set properly.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "'azurerm_managed_disk' disk_encryption_set_id should be configured.",
		"snippet": block,
	}
}
