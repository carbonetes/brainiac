# METADATA
# title: "Verify Rancher2 Feature Value"
# description: "Policy to verify Rancher2 Feature Value, ensuring that the 'value' field is provided."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/feature
# custom:
#   id: CB_TFRAN_189
#   severity: LOW
package lib.terraform.CB_TFRAN_189

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_feature" in block.Labels
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
	not is_boolean(block.Attributes.value)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Feature Value has been successfully validated with the specified settings.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Feature Value configuration. Ensure that the 'value' field is provided and specified correctly.",
		"snippet": block,
	}
}
