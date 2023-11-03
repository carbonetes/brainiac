# METADATA
# title: "Make certain that Azure File Sync is configured to prevent public network accessibility"
# description: "Confirm that Azure File Sync is configured to block public network access, confirming that sensitive data remains secured within the private network."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_sync
# custom:
#   id: CB_TFAZR_091
#   severity: LOW
package lib.terraform.CB_TFAZR_091

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_storage_sync" in block.Labels
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
	block.Attributes.incoming_traffic_policy == "AllowVirtualNetworksOnly"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure File Sync is configured to prevent public network accessibility.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure File Sync must be configured to prevent public network accessibility.",
		"snippet": block,
	}
}