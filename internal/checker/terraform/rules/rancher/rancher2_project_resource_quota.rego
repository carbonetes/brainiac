# METADATA
# title: "Verify Rancher2 Project Resource Quota"
# description: "This policy ensures that the required attributes for Resource Quota are properly configured in Rancher2 Project."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/project
# custom:
#   id: CB_TFRAN_175
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_175

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_project" in block.Labels
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
	some innerblock in block.Blocks
	innerblock.Type == "resource_quota"
	some innerblock2 in innerblock.Blocks
	not innerblock2.Type == "project_limit"
    not innerblock2.Type == "namespace_default_limit"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Proper configuration for Resource Quota in Rancher2 Project is verified.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Ensure proper configuration for Resource Quota in Rancher2 Project.",
		"snippet": block,
	}
}
