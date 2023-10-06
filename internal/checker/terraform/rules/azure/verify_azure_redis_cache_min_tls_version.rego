# METADATA
# title: "Verify Redis Cache is using the latest version of TLS encryption"
# description: "This policy is designed to enhance the security of Redis Cache instances by verifying that they are using the latest version of TLS (Transport Layer Security) encryption."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache
# custom:
#   id: CB_TFAZR_133
#   severity: LOW
package lib.terraform.CB_TFAZR_133

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
	block.Attributes.minimum_tls_version == "1.2"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Redis Cache is using the latest version of TLS encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Redis Cache is not using the latest version of TLS encryption.",
		"snippet": block,
	}
}