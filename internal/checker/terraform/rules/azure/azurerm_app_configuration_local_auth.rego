# METADATA
# title: "Verify if local_auth_enabled Set to False"
# description: "Ensure that the local_auth_enabled attribute is not set to True to prevent the use of local authentication methods"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration
# custom:
#   id: CB_TFAZR_162
#   severity: HIGH
package lib.terraform.CB_TFAZR_162

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_app_configuration" in block.Labels
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
	resource.Attributes.local_auth_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The 'local_auth_enabled' attribute is set to 'False,' which disallows the use of local authentication methods.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The 'local_auth_enabled' attribute should be set to 'False' to disallow the use of local authentication methods.",
		"snippet": block,
	}
}