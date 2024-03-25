# METADATA
# title: "Verify send email notifications is enabled for high severity alerts"
# description: "This policy ensures that your organization's security team receives automatic email alerts for potential security issues, enabling swift risk mitigation. Activating Send email notification for high severity alerts ensures prompt emails from Microsoft in case of a potential breach."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.security/securitycontacts?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_021
#   severity: LOW
package lib.azurearm.CB_AZR_021
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
    lower(properties.alertNotifications) != "on"
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

