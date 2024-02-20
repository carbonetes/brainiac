# METADATA
# title: "Verify Rancher2 Registry Configuration"
# description: "Policy to verify Rancher2 Registry Configuration for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/registry
# custom:
#   id: CB_TFRAN_097
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_097

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_registry" in block.Labels
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
		"message": "All Rancher2 Registry Configurations are valid and comply with specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Registry Configuration. Both 'name' and 'project_id' fields are required. Please ensure valid values are provided to meet configuration requirements.",
		"snippet": block,
	}
}
