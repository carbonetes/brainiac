# METADATA
# title: "Verify MySQL DB instance has point-in-time recovery backup configured"
# description: "This ensures that a MySQL database instance is set up with point-in-time recovery backup, allowing for data restoration to a specific point in time, enhancing data protection and recovery capabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/3.44.0/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_124
#   severity: LOW
package lib.terraform.CB_TFGCP_124
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

fail[block] {
    some block in input
	isvalid(block)
	contains(block.Attributes.database_version, "MYSQL")
	some first_block in block.Blocks
	first_block.Type == "settings"
	some second_block in first_block.Blocks
	second_block.Type == "backup_configuration"
	second_block.Attributes.binary_log_enabled != "true"

}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "MySQL DB instance has point-in-time recovery backup configured.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "MySQL DB instance point-in-time recovery backup should be configured.",
                "snippet": block }
}