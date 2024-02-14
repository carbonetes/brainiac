# METADATA
# title: "Restrict Public Access for Azure Cognitive Search Allowed IPs"
# description: "This policy verifies that the allowed IP addresses configured for an Azure Cognitive Search service do not allow public access. Allowing public access could potentially expose sensitive data and affect security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/search_service
# custom:
#   id: CB_TFAZR_207
#   severity: HIGH
package lib.terraform.CB_TFAZR_207

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_search_service" in block.Labels
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
	not "0.0.0.0/0" in resource.Attributes.allowed_ips
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Azure Cognitive Search service's allowed IP addresses do not allow public access, enhancing security.",
		"snippet": block, 
    }
}

failed[result] {
	some block in fail
	result := {
		"message": "The Azure Cognitive Search service's allowed IP addresses grant public access, which can lead to security vulnerabilities and should be restricted.",
		"snippet": block, 
    }
}
