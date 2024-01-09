# METADATA
# title: "Disallow Assignment of Public IP to Database Cluster"
# description: "This policy ensures that database clusters do not have public IP addresses assigned. Assigning public IPs to database clusters may expose sensitive data and services to unauthorized access, compromising security."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/mdb_clickhouse_cluster
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/mdb_kafka_cluster
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/mdb_greenplum_cluster
# custom:
#   id: CB_TFYC_012
#   severity: MEDIUM
package lib.terraform.CB_TFYC_012

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"yandex_mdb_postgresql_cluster",
		"yandex_mdb_sqlserver_cluster",
		"yandex_mdb_mysql_cluster",
		"yandex_mdb_mongodb_cluster",
		"yandex_mdb_kafka_cluster",
		"yandex_mdb_greenplum_cluster",
		"yandex_mdb_elasticsearch_cluster",
		"yandex_mdb_clickhouse_cluster",
	]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "host"
	block.Attributes.assign_public_ip == true
}

fail[resource] {
	some resource in input
	resource.Type == "resource"
	"yandex_mdb_kafka_cluster" in resource.Labels
	some block in resource.Blocks
	block.Type == "config"
	block.Attributes.assign_public_ip == true
}

fail[resource] {
	some resource in input
	resource.Type == "resource"
	"yandex_mdb_greenplum_cluster" in resource.Labels 
	resource.Attributes.assign_public_ip == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "config"
	block.Attributes.assign_public_ip == true
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The database cluster is correctly configured without a public IP address, minimizing exposure to potential security risks.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "A public IP address is assigned to the database cluster. It is essential to avoid exposing databases to the public internet for enhanced security.",
		"snippet": block,
	}
}
