# METADATA
# title: "Verify that there are no custom subscription owner roles created"
# description: "This policy emphasizes that subscription ownership should not grant permissions to create custom owner roles. It advocates for adhering to the principle of least privilege, advocating for assigning only necessary privileges rather than providing full administrative access."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.authorization/roledefinitions?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_039
#   severity: CRITICAL
package lib.azurearm.CB_AZR_039

import future.keywords.in

resource := "Microsoft.Authorization/roleDefinitions"

is_valid {
	some resources in input.resources
	resources.type == resource
}

fail[properties] {
	some resource in input.resources
	properties := resource.properties
	"assignableScopes" in object.keys(properties)
}

fail[properties] {
	some resource in input.resources
	properties := resource.properties
	permissions := properties.permissions
	"actions" in object.keys(permissions)
	"*" in permissions.actions
}

pass[resources] {
	resources := input.resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "No custom subscription owner roles are created.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Custom subscription owner roles are created.",
		"snippet": block,
	}
}
