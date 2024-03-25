# METADATA
# title: "Verify that SecureString parameter should not have hardcoded default values"
# description: "This policy ensures that SecureString parameters in your Azure resources do not have hardcoded default values. Having hardcoded values can expose sensitive data and potentially compromise the security of your resources."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-test-cases#secure-parameters-cant-have-hardcoded-default
# custom:
#   id: CB_AZR_071
#   severity: LOW
package lib.azurearm.CB_AZR_071

import future.keywords.in

resource := "secureString"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[resource] {
	is_valid
	some resource in input.resources
	not "defaultValue" in object.keys(resource)
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "SecureString parameter does not have hardcoded default values.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "SecureString parameter should not have hardcoded default values.",
		"snippet": block,
	}
}
