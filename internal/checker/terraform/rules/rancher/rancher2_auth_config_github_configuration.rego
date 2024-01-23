# METADATA
# title: "Verify Rancher GitHub Authentication Configuration"
# description: "This policy ensures that the Rancher GitHub configuration includes valid Client ID and Client Secret."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_github
# custom:
#   id: CB_TFRAN_017
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_017

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_auth_config_github" in block.Labels
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
	block.Attributes.client_id != ""
	block.Attributes.client_secret != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher GitHub configuration includes valid Client ID and Client Secret.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher GitHub configuration is missing valid Client ID or Client Secret. Update the configuration accordingly.",
		"snippet": block,
	}
}