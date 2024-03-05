# METADATA
# title: "Verify Rancher2 Token Renew"
# description: "Policy to verify Rancher2 Token Renew configuration, ensuring that the 'renew' option is specified correctly to renew the token if expired or disabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/token
# custom:
#   id: CB_TFRAN_186
#   severity: LOW
package lib.terraform.CB_TFRAN_186

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_token" in block.Labels
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
		"message": "Rancher2 Token Renew configuration has been successfully validated with the specified settings.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Token Renew configuration. Ensure that the 'renew' option is correctly specified to renew the token if expired or disabled.",
		"snippet": block,
	}
}
