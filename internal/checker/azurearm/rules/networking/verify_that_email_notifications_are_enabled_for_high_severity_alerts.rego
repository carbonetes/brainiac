# METADATA
# title: "Verify email notifications is enabled for high severity alerts to administrators"
# description: "This policy ensures that subscription owners receive security alert emails from Microsoft, ensuring timely awareness and risk mitigation. We recommend configuring security alert emails to be sent to subscription owners."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.security/securitycontacts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_022
#   severity: MEDIUM
package lib.azurearm.CB_AZR_022
import future.keywords.in

resource := "Microsoft.Security/securityContacts"

is_valid{
	some res in input.resources
    res.type == resource
}

fail[properties]{
    is_valid
	some resource in input.resources
    properties := resource.properties
    lower(properties.alertsToAdmins) != "on"
}

pass[resources] {
    resources := input.resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some properties in pass
	result := { "message": "Send email notification high severity alerts is on.",
                "snippet": properties }
}

failed[result] {
    some properties in fail
	result := { "message": "Send email notification high severity alerts should be on",
                "snippet": properties }
} 

