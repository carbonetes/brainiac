# METADATA
# title: "Verify that a MySQL database instance does not allow anyone to connect with administrative privileges"
# description: "This ensures that access to the MySQL database is appropriately restricted, reducing the risk of unauthorized administrative access and potential security vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user
# custom:
#   id: CB_TFGCP_106
#   severity: LOW
package lib.terraform.CB_TFGCP_106

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_sql_user" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_db_instance[label] {
	some block in input
	block.Type == "resource"
	"google_sql_database_instance" in block.Labels
    startswith(block.Attributes.database_version, "MYSQL")
	label := concat(".", block.Labels)
}

instance_connected(block){
	some label in label_for_db_instance
	contains(block.Attributes.instance, label)
}

fail[block] {
	some block in input
	isvalid(block)
	instance_connected(block)
	startswith(block.Attributes.name, "root")
	block.Attributes.password != ""
}


pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "MySQL database instance does not allow anyone to connect with administrative privileges.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "MySQL database instance should not allow anyone to connect with administrative privileges.",
		"snippet": block,
	}
}
