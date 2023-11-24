# METADATA
# title: "Verify SQL database is using latest Major version"
# description: "This helps benefit from the latest features, improvements, and security updates provided by the database service."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_076
#   severity: LOW
package lib.terraform.CB_TFGCP_076
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_sql_database_instance" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
    some block in input
	isvalid(block)
	major_versions := ["POSTGRES_15", "MYSQL_8_0", "SQLSERVER_2019_STANDARD", "SQLSERVER_2019_WEB",
                		"SQLSERVER_2019_ENTERPRISE", "SQLSERVER_2019_EXPRESS"]
	block.Attributes.database_version in major_versions
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "SQL database is using latest Major version.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "SQL database should use the latest Major version.",
                "snippet": block }
}