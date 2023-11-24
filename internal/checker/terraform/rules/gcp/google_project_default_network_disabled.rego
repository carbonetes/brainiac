# METADATA
# title: "Verify Absence of Default Network in a Project"
# description: "This policy checks whether the default network exists within a project. The default network is not recommended for production use due to security considerations."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project
# custom:
#   id: CB_TFGCP_030
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_030

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"google_project" in resource.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.auto_create_network == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "No default network exists in the project, ensuring a more secure network configuration.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The default network is present in the project, posing potential security risks. Consider using a custom network configuration.",
		"snippet": block,
	}
}