# METADATA
# title: "Confirm that the Machine Learning Workspace has deactivated Public Access"
# description: "Enhance security and limit unauthorized access by verifying the deactivation of Public Access for the Machine Learning Workspace."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace
# custom:
#   id: CB_TFAZR_163
#   severity: LOW
package lib.terraform.CB_TFAZR_163

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_machine_learning_workspace" in block.Labels
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
	resource.Attributes.public_network_access_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Machine Learning Workspace has deactivated Public Access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Machine Learning Workspace must deactivate Public Access.",
		"snippet": block,
	}
}
