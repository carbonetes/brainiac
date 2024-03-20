# METADATA
# title: "Verify MySQL Server Infrastructure Encryption Activation"
# description: "Validate the activation of infrastructure encryption within the MySQL server environment to bolster security measures and safeguard sensitive data."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.dbformysql/flexibleservers?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_057
#   severity: LOW
package lib.azurearm.CB_AZR_057
import future.keywords.in

resource := "Microsoft.DBforMySQL/flexibleServers"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    some encrypt in properties.dataEncryption
    encrypt != ""
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Infrastructure encryption enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Infrastructure encryption disabled",
		"snippet": block,
	}
}
