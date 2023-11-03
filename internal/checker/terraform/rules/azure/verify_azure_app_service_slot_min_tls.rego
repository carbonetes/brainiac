# METADATA
# title: "Verify the App service slot is using the latest version of TLS encryption"
# description: "This policy is designed to enhance the security and data protection of Azure App Service Slots by verifying that they are configured to use the latest version of TLS (Transport Layer Security) encryption."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_slot
# custom:
#   id: CB_TFAZR_167
#   severity: LOW
package lib.terraform.CB_TFAZR_167

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_app_service_slot" in block.Labels
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
	innerBlock.Type == "site_config"
	innerBlock.Attributes.min_tls_version == "1.2"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Azure App Service Slot is configured to use TLS 1.2.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Azure App Service Slot is not configured to use TLS 1.2.",
		"snippet": block,
	}
}