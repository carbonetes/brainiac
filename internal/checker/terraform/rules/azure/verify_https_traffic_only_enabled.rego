# METADATA
# title: "Verify that enable_https_traffic_only is enabled"
# description: "enable_https_traffic_only is a security feature that enforces the use of the HTTPS protocol for all communication between a web application or service and its clients."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account
# custom:
#   id: CB_TFAZR_047
#   severity: HIGH
package lib.terraform.CB_TFAZR_047

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_storage_account" in block.Labels
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
	resource.Attributes.enable_https_traffic_only == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "'azurerm_storage_account' enable_https_traffic_only is set properly.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "'azurerm_storage_account' enable_https_traffic_only should be set to 'true'",
		"snippet": block,
	}
}
