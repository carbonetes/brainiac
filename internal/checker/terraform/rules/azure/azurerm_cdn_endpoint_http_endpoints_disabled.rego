# METADATA
# title: "Disable HTTP Endpoint for Azure CDN"
# description: "This policy enforces the disabling of the HTTP endpoint for Azure Content Delivery Network (CDN), enhancing security and performance by restricting non-secure traffic."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_endpoint
# custom:
#   id: CB_TFAZR_193
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_193

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_cdn_endpoint" in block.Labels
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
	resource.Attributes.is_http_allowed == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The HTTP endpoint for Azure CDN is disabled, enhancing security and performance.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "The HTTP endpoint for Azure CDN should be disabled to improve security and performance by restricting non-secure traffic.",
		"snippet": block, 
    }
}
