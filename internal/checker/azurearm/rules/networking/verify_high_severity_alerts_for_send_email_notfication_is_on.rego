# METADATA
# title: "Verify high severity alerts for send email notfication is on"
# description: "Validate that the email notification system is configured to send alerts for high-severity incidents, ensuring timely awareness and response to critical issues."
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

