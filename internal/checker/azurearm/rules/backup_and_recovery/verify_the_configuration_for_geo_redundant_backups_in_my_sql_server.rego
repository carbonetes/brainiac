# METADATA
# title: "Verify geo-redundant backups is enabled for My SQL server"
# description: "This policy mandates enabling geo-redundant backups for Microsoft Azure MySQL database servers. It allows for restoration to a different Azure region in case of regional outages or disasters. During geo-restore, configuration changes such as compute generation, vCore, backup retention period, and redundancy options can be adjusted."
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