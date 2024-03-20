# METADATA
# title: "Verify the Configuration for Geo-Redundant Backups in My SQL Server"
# description: "Validate and ensure the configuration of the MySQL server supports the implementation of geo-redundant backup solutions, safeguarding data integrity and availability across diverse geographic locations."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.dbformysql/flexibleservers?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_055
#   severity: LOW
package lib.azurearm.CB_AZR_055
import future.keywords.in

resource := "Microsoft.DBforMySQL/flexibleServers"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
 	is_valid
	some resource in input.resources
    properties := resource.properties.Backup
    properties.geoRedundantBackup == "Enabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Geo-redundant backups enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Geo-redundant backups should be enabled",
		"snippet": block,
	}
}