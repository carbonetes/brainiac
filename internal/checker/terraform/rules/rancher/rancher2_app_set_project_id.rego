# METADATA
# title: "Verify Setting of Rancher Project ID"
# description: "This policy ensures that the Rancher project ID is properly configured. The project ID is a crucial identifier within Rancher environments."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/app
# custom:
#   id: CB_TFRAN_001
#   severity: LOW
package lib.terraform.CB_TFRAN_001

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_app" in block.Labels
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
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher project ID is correctly set, meeting configuration requirements.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher project ID is not configured. Please set the project ID to ensure proper identification within the Rancher environment.",
		"snippet": block,
	}
}
