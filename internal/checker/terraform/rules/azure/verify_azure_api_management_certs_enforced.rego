# METADATA
# title: "Verify Client Certificates are enforced for API management"
# description: "This policy is designed to enhance the security and access control of API management services by verifying that client certificates are enforced."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management
# custom:
#   id: CB_TFAZR_154
#   severity: LOW
package lib.terraform.CB_TFAZR_154

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_api_management" in block.Labels
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
	block.Attributes.client_cert_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Client certificates are enforced for API management.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Client certificates are not enforced for API management.",
		"snippet": block,
	}
}