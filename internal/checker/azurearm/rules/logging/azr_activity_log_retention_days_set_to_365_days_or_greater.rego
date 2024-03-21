# METADATA
# title: "Verify Activity Log Retention is configured for 365 days or longer"
# description: "This policy advises setting the activity log retention period to 365 days or longer. By retaining the activity log for this duration, organizations have ample time to detect and respond to any security breaches, considering that the average time to detect a breach is 210 days."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.insights/logprofiles?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_037
#   severity: MEDIUM
package lib.azurearm.CB_AZR_037

import future.keywords.in

resource := "Microsoft.Insights/logprofiles"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
	some resource in input.resources
	properties := resource.properties.retentionPolicy
	lower(properties.enabled) == "true"
	days = to_number(properties.days)
	days >= 365
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Activity Log Retention is set 365 days or greater.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Activity Log Retention is not set 365 days or greater.",
		"snippet": block,
	}
}
