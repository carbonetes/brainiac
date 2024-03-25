# METADATA
# title: "Verify SQL server has disabled public network access"
# description: "This policy ensures your SQL server isn't public, shielding your data from unauthorized access or tampering. Public SQL servers are vulnerable to external threats like hackers or malware. By making it private, only authorized users can access the data, enhancing security."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.sql/servers?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_066
#   severity: LOW
package lib.azurearm.CB_AZR_066
import future.keywords.in

resource := "Microsoft.Sql/servers"

is_valid {
	some resources in input.resources
	resources.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    "publicNetworkAccess" in object.keys(properties)
    public := properties.publicNetworkAccess
    public == "Disabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "SQL server does disables public network access",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "SQL server does not disable public network access",
		"snippet": block,
	}
}