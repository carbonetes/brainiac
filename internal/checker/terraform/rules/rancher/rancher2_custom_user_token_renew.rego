# METADATA
# title: "Verify Rancher2 Custom User Token with Token Renewal"
# description: "Policy to verify that Rancher2 Custom User Token configuration includes Token Renewal."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/custom_user_token
# custom:
#   id: CB_TFRAN_122
#   severity: LOW
package lib.terraform.CB_TFRAN_122

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_custom_user_token" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
	some block in input
	isvalid(block)
    block.Attributes.renew != true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Custom User Token configuration successfully validated with Token Renewal included.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Custom User Token configuration. Ensure that 'renew' is included and set appropriately. It must be specified as a boolean value, defaulting to 'true' to renew the token if expired or disabled.",
		"snippet": block,
	}
}
