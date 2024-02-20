# METADATA
# title: "Verify Rancher2 Feature Configuration"
# description: "Policy to validate Rancher2 Feature Configuration for compliance with specified standards and parameters."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/feature
# custom:
#   id: CB_TFRAN_080
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_080

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

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.name != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Validation of Rancher2 Feature Configuration is successful, in line with specified standards and parameters.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Feature Configuration detected. Review and adjust settings to meet compliance standards and specified parameters.",
		"snippet": block,
	}
}
