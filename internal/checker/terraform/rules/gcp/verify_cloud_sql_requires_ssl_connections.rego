# METADATA
# title: "Verify all Cloud SQL database instance requires all incoming connections to use SSL"
# description: "Enforcing SSL connections enhances the security and confidentiality of data transmitted to and from the database, protecting it from potential eavesdropping and unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_010
#   severity: HIGH
package lib.terraform.CB_TFGCP_010
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
	second_block.Type == "ip_configuration"
	second_block.Attributes.require_ssl == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Cloud SQL database instance requires all incoming connections to use SSL.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Cloud SQL database instance should requires all incoming connections to use SSL.",
                "snippet": block }
}