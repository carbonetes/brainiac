# METADATA
# title: "Verify infrastructure encryption for PostgresSQL server is enabled"
# description: "This policy ensures heightened data security for Azure Database for PostgreSQL servers by enabling infrastructure encryption. With this, data at rest undergoes dual encryption using FIPS 140-2 compliant Microsoft managed keys."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.dbforpostgresql/2017-12-01/servers?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_070
#   severity: LOW
package lib.azurearm.CB_AZR_070
import future.keywords.in

resource := "Microsoft.DBforPostgreSQL/servers"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
	is_valid
	some resource in input.resources
    properties := resource.properties
    "infrastructureEncryption" in object.keys(properties)
    encryption := properties.infrastructureEncryption
    encryption == "Enabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "PostgreSQL server enables infrastructure encryption",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "PostgreSQL server does not enable infrastructure encryption",
		"snippet": block,
	}
}