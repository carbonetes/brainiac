# METADATA
# title: "Verify Secure AzureAD Endpoint URLs"
# description: "This policy ensures that AzureAD endpoint URLs (auth_endpoint and token_endpoint) are valid and use a secure HTTPS scheme."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_azuread
# custom:
#   id: CB_TFRAN_013
#   severity: LOW
package lib.terraform.CB_TFRAN_013

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_auth_config_azuread" in block.Labels
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
	startswith( block.Attributes.auth_endpoint, "https://") 
	startswith(block.Attributes.token_endpoint, "https://")
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "AzureAD endpoint URLs are valid and use a secure HTTPS scheme.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "AzureAD endpoint URLs must be valid and use a secure HTTPS scheme.",
		"snippet": block,
	}
}
