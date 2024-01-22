# METADATA
# title: "Verify Rancher FreeIPA Configuration"
# description: "This policy ensures that the Rancher FreeIPA configuration has required settings for proper integration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_freeipa
# custom:
#   id: CB_TFRAN_014
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_014

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_auth_config_freeipa" in block.Labels
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
	block.Attributes.service_account_distinguished_name != ""
	block.Attributes.service_account_password != ""
	block.Attributes.test_username != ""
	block.Attributes.test_password != ""
	block.Attributes.user_search_base != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher FreeIPA configuration has the required settings.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher FreeIPA configuration is missing required settings. Update the configuration accordingly.",
		"snippet": block,
	}
}
