# METADATA
# title: "Verify Spring Cloud API Portal Public Access Is Disabled"
# description: "This policy is designed to enhance the security and access control of Spring Cloud API Portal by verifying that public access is disabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/spring_cloud_api_portal
# custom:
#   id: CB_TFAZR_178
#   severity: LOW
package lib.terraform.CB_TFAZR_178

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_spring_cloud_api_portal" in block.Labels
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
		"message": "Public access for Spring Cloud API Portal is disabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Public access for Spring Cloud API Portal is enabled.",
		"snippet": block,
	}
}