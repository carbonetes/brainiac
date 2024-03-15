# METADATA
# title: "Verify Rancher2 Namespace Configuration"
# description: "Policy ensuring Rancher2 Namespace Configuration validation, in accordance with specified parameters and standards"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/namespace
# custom:
#   id: CB_TFRAN_087
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_087

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_namespace" in block.Labels
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
    block.Attributes.project_id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Successful validation of Rancher2 Namespace Configuration, ensuring compliance with specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Namespace Configuration validation. Please review and adjust settings to meet specified parameters and standards.",
		"snippet": block,
	}
}
