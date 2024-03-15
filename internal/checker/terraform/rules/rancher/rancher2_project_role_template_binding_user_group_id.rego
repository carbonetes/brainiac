# METADATA
# title: "Verify User and Group IDs in Rancher2 Project Role Template Binding Configuration"
# description: "Policy to verify User and Group IDs in Rancher2 Project Role Template Binding Configuration for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/project_role_template_binding
# custom:
#   id: CB_TFRAN_179
#   severity: LOW
package lib.terraform.CB_TFRAN_179

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_project_role_template_binding" in block.Labels
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
	block.Attributes.user_id == ""
	block.Attributes.user_principal_id == ""
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.group_id == ""
	block.Attributes.group_principal_id == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "User and Group IDs in Rancher2 Project Role Template Binding Configuration have been successfully verified, meeting specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Project Role Template Binding Configuration. User and Group IDs are not defined. Please ensure that valid IDs are provided to meet configuration requirements.",
		"snippet": block,
	}
}
