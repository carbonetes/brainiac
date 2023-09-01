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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_elasticache_replication_group"
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.automatic_failover_enabled == true
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "AWS ElastiCache Redis cluster with Multi-AZ Automatic Failover feature is enabled.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "AWS ElastiCache Redis cluster with Multi-AZ Automatic Failover feature is disabled.",
		"snippet": block,
	}
}
