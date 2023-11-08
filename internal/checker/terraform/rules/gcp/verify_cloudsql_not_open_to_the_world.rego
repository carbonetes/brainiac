# METADATA
# title: "Verify that Cloud SQL database Instances are not open to the world"
# description: "Restricting access to these database instances enhances security by preventing unauthorized access from untrusted sources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_020
#   severity: HIGH
package lib.terraform.CB_TFGCP_020
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
	some first_block in block.Blocks
	first_block.Type == "settings"
	some second_block in first_block.Blocks
	second_block.Type == "ip_configuration"
	some third_block in second_block.Blocks
	third_block.Type == "dynamic"
	"authorized_networks" in third_block.Labels
	some fourth_block in third_block.Blocks
	fourth_block.Type == "content"
	endswith(fourth_block.Attributes.value, "/0")
}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "Cloud SQL database instances are not publicly accessible.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Cloud SQL database instances are should not publicly accessible.",
                "snippet": block }
}