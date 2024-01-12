# METADATA
# title: "Assign Security Group to Database Cluster"
# description: "This policy mandates the assignment of a security group to a database cluster. Assigning a security group enhances network security and access control for the database cluster."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/mdb_clickhouse_cluster
# custom:
#   id: CB_TFYC_001
#   severity: LOW 
package lib.terraform.CB_TFYC_001

import future.keywords.in

isvalid(block) {
    supported_resources := [
        "yandex_mdb_postgresql_cluster",
        "yandex_mdb_sqlserver_cluster",
        "yandex_mdb_redis_cluster",
        "yandex_mdb_mysql_cluster",
        "yandex_mdb_mongodb_cluster",
        "yandex_mdb_kafka_cluster",
        "yandex_mdb_greenplum_cluster",
        "yandex_mdb_elasticsearch_cluster",
        "yandex_mdb_clickhouse_cluster"
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

pass[resource] {
    some resource in input
    isvalid(resource)
	count(resource.Attributes.security_group_ids) != 0
}

fail[resource] {
    some resource in input
    isvalid(resource)
    not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "A security group has been successfully assigned to the database cluster, ensuring enhanced network security.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": sprintf("No security group is assigned to the database cluster (%v). It is recommended to assign a security group to enhance network security and access control.", [block.Attributes.name]),
        "snippet": block,
    }
}