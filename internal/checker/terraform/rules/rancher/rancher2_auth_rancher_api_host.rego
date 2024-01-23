# METADATA
# title: "Verify Rancher Auth Configurations API Host uses HTTPS"
# description: "This policy ensures that the Rancher auth configurations API Host is using HTTPS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_adfs
# custom:
#   id: CB_TFRAN_010
#   severity: LOW
package lib.terraform.CB_TFRAN_010

import future.keywords.in

isvalid(block) {
    supported_resources := [
		"rancher2_auth_config_keycloak",
		"rancher2_auth_config_adfs",
		"rancher2_auth_config_okta"
	]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
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
	startswith(block.Attributes.rancher_api_host, "https://")
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher Auth configurations rancher_api_host uses HTTPS.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher Auth configurations rancher_api_host must use HTTPS. Update the configuration accordingly.",
		"snippet": block,
	}
}
