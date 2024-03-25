# METADATA
# title: "Verify infrastructure encryption are enabled for MySQL Server"
# description: "This policy mandates enabling infrastructure encryption for Azure Database for MySQL servers to ensure higher data security assurance. It involves double encryption of data at rest using FIPS 140-2 compliant Microsoft managed keys."
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
