# METADATA
# title: "Verify Rancher2 Project Alert Group Configuration"
# description: "This policy ensures that Rancher2 Project Alert Group Configuration aligns with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/project_alert_group
# custom:
#   id: CB_TFRAN_094
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_094

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_project_alert_group" in block.Labels
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
		"message": "Successful validation of Rancher2 Project Alert Group Configuration, aligning with specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Project Alert Group Configuration. Both the 'name' and 'project_id' fields are required. Please ensure valid values are provided to meet configuration requirements.",
		"snippet": block,
	}
}
