# METADATA
# title: "Verify audit profile is set to capture all activities"
# description: "This policy recommends configuring the log profile to export logs for the categories Write, Delete, and Action. By doing so, it ensures that all activities related to the control/management plane, such as resource creation, deletion, and modifications, are captured and exported. This comprehensive logging approach provides visibility into all control/management plane activities performed on the subscription."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.insights/logprofiles?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_038
#   severity: LOW
package lib.azurearm.CB_AZR_038

import future.keywords.in

resource := "Microsoft.Insights/logprofiles"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
	is_valid
	some resource in input.resources
	properties := resource.properties
	categories := {"Write", "Delete", "Action"}
	all_categories := {category | some category in properties.categories}
	categories == all_categories
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "The log profile is correctly configured to capture all activities (Write, Delete, Action).",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The log profile is not configured to capture all activities (Write, Delete, Action).",
		"snippet": block,
	}
}
