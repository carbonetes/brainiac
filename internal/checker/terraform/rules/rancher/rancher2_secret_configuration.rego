# METADATA
# title: "Verify Rancher2 Secret Configuration"
# description: "Policy to verify Rancher2 Secret Configuration for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/secret
# custom:
#   id: CB_TFRAN_099
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_099

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

pass[block] {
	some block in input
	isvalid(block)
	is_object(block.Attributes.data)
	count(block.Attributes.data) > 0
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
		"message": "All Rancher2 Secret Configurations have been successfully validated, meeting specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Secret Configuration. Both 'data' and 'project_id' fields are required. Ensure valid values are provided to meet configuration requirements.",
		"snippet": block,
	}
}
