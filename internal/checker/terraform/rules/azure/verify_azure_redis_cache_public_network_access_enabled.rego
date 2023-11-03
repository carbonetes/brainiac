# METADATA
# title: "Verify that Azure Cache for Redis disables public network access"
# description: "This policy is designed to enhance the security and access control of Azure Cache for Redis by verifying that public network access is disabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache
# custom:
#   id: CB_TFAZR_096
#   severity: LOW
package lib.terraform.CB_TFAZR_096

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_redis_cache" in block.Labels
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
	block.Attributes.public_network_access_enabled == false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Public network access is enabled for Azure Cache for Redis.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Public network access is disabled for Azure Cache for Redis.",
		"snippet": block,
	}
}