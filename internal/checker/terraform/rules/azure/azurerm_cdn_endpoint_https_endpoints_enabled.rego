# METADATA
# title: "Enable HTTPS Endpoint for Azure CDN"
# description: "This policy mandates the enabling of the HTTPS endpoint for Azure Content Delivery Network (CDN), enhancing security by providing secure communication."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cdn_endpoint
# custom:
#   id: CB_TFAZR_194
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_194

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
	resource.Attributes.is_https_allowed == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure CDN has the HTTPS endpoint enabled, ensuring secure communication.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure CDN should enable the HTTPS endpoint to enhance security by providing secure communication.",
		"snippet": block, 
    }
}
