# METADATA
# title: Verify Rancher2 Token Configuration"
# description: "This policy ensures Rancher2 Token Configuration aligns with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/token
# custom:
#   id: CB_TFRAN_103
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_103

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
	block.Attributes.cluster_id == ""
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.description == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "All Rancher2 Token Configurations have been successfully validated, meeting specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 Token Configuration has invalid or missing attributes. Check and fix the configuration.",
		"snippet": block,
	}
}
