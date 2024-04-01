# METADATA
# title: "Verify that Amazon ElastiCache Redis clusters have automatic backup turned on"
# description: "By enabling automatic backups for Amazon ElastiCache Redis clusters is important to ensure data protection, facilitate disaster recovery, and minimize downtime in case of accidental data loss or system failures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster.html#snapshot_retention_limit
# custom:
#   id: CB_TFAWS_113
#   severity: LOW
package lib.terraform.CB_TFAWS_113

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_elasticache_cluster"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_number(to_number(resource.Attributes.snapshot_retention_limit))
	to_number(resource.Attributes.snapshot_retention_limit) > 0
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_elasticache_cluster' for 'snapshot_retention_limit' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_elasticache_cluster' for 'snapshot_retention_limit' should be set.",
		"snippet": block,
	}
}