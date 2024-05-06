# METADATA
# title: "Verify AWS ElastiCache Redis cluster with Multi-AZ Automatic Failover feature set to enabled"
# description: "This policy aims to ensure the high availability and fault tolerance of Amazon Web Services (AWS) ElastiCache Redis clusters by verifying that the Multi-AZ Automatic Failover feature is enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
# custom:
#   id: CB_TFAWS_367
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_367

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_elasticache_replication_group"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains block if {
	some block in input
	isvalid(block)
	block.Attributes.automatic_failover_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS ElastiCache Redis cluster with Multi-AZ Automatic Failover feature is enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS ElastiCache Redis cluster with Multi-AZ Automatic Failover feature is disabled.",
		"snippet": block,
	}
}
