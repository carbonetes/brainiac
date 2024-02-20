# METADATA
# title: "Verify Rancher2 Role Template Configuration"
# description: "Policy to verify Rancher2 Role Template Configuration for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/role_template
# custom:
#   id: CB_TFRAN_098
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_098

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_role_template" in block.Labels
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
		"message": "All Rancher2 Role Template Configurations are valid and comply with specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Role Template Configuration. The 'name' field is required. Please ensure a valid value is provided to meet configuration requirements.",
		"snippet": block,
	}
}
