# METADATA
# title: "Verify Rancher2 Project Alert Rule Configuration"
# description: "This policy ensures that Rancher2 Project Alert Rule Configuration aligns with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/project_alert_rule
# custom:
#   id: CB_TFRAN_095
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_095

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_project_alert_rule" in block.Labels
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
    block.Attributes.project_id != ""
    block.Attributes.group_id != ""
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
		"message": "All Rancher2 Project Alert Rule configurations successfully validated, meeting specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Project Alert Rule Configuration. The 'project_id,' 'group_id,' and 'name' fields are required. Please ensure valid values are provided to meet configuration requirements.",
		"snippet": block,
	}
}
