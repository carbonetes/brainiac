# METADATA
# title: "Verify that only SSL are enabled for Cache for Redis"
# description: "This encryption ensures data confidentiality, authentication, and protection against network threats, helping meet compliance requirements and preventing data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache
# custom:
#   id: CB_TFAZR_065
#   severity: LOW
package lib.terraform.CB_TFAZR_065

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

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.enable_non_ssl_port == false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "azurerm_redis_cache 'enable_non_ssl_port' is set properly.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "azurerm_redis_cache 'enable_non_ssl_port' should be set to false.",
		"snippet": block,
	}
}
