# METADATA
# title: "Verify that the Cloud SQL database is not assigned a public IP address"
# description: "Confirm that the Cloud SQL database does not possess a public IP address to enhance security and restrict external access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance
# custom:
#   id: CB_TFGCP_055
#   severity: LOW
package lib.terraform.CB_TFGCP_055

import future.keywords.in

isvalid(block) {
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
	some inner_block in block.Blocks
	inner_block.Type == "settings"
	some ip_config_block in inner_block.Blocks
	ip_config_block.Type == "ip_configuration"
	ip_config_block.Attributes.ipv4_enabled == "true"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Cloud SQL database does not contain a public IP address.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Cloud SQL database contains a public IP address.",
		"snippet": block,
	}
}
