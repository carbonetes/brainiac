# METADATA
# title: "Verify all Cloud SQL database instance have backup configuration enabled"
# description: "Enabling backup configuration is crucial for data protection and disaster recovery."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_027
#   severity: HIGH
package lib.terraform.CB_TFGCP_027
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
   	some first_block in block.Blocks
	first_block.Type == "settings"
	some second_block in first_block.Blocks
	second_block.Type == "backup_configuration"
	second_block.Attributes.enabled == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Cloud SQL database instance have backup configuration enabled.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Cloud SQL database instance should have backup configuration enabled.",
                "snippet": block }
}