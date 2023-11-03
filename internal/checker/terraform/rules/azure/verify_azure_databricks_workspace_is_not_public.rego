# METADATA
# title: "Verify that databricks workspace has not public"
# description: "This policy is designed to enhance the security and access control of Databricks workspaces by verifying that they are not publicly accessible."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace
# custom:
#   id: CB_TFAZR_173
#   severity: LOW
package lib.terraform.CB_TFAZR_173

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_databricks_workspace" in block.Labels
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
	block.Attributes.public_network_access_enabled == false
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Databricks workspace does not have public network access enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Databricks workspace has public network access enabled.",
		"snippet": block,
	}
}