# METADATA
# title: "Verify Rancher2 Secret Namespaced Secret "
# description: "Policy to verify Rancher2 Secret Namespaced Secret, ensuring that the 'namespace_id' is specified for assignment to the namespaced secret."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/secret
# custom:
#   id: CB_TFRAN_183
#   severity: LOW
package lib.terraform.CB_TFRAN_183

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_secret" in block.Labels
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
	block.Attributes.namespace_id == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Secret Namespaced Secret successfully validated with the 'namespace_id' assigned.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Secret Namespaced Secret. Please ensure that the 'namespace_id' is specified for assignment.",
		"snippet": block,
	}
}
