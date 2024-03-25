# METADATA
# title: "Verify security contact's 'Phone number' is configured"
# description: "This policy ensures that Microsoft can contact the designated security contact if its security team detects any compromise to the organization's resources."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.security/securitycontacts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_020
#   severity: LOW
package lib.azurearm.CB_AZR_020

import future.keywords.in

resource := "Microsoft.Security/securityContacts"

is_valid {
	some resources in input.resources
	resources.type == resource
}

fail[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	not "phone" in object.keys(properties)
}

pass[resources] {
	resources := input.resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Phone number is set.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Phone number is not set.",
		"snippet": block,
	}
}
