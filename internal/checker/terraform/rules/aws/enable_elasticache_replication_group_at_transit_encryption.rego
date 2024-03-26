# METADATA
# title: "Enable Encryption at transit for ElastiCache Replication Groups"
# description: "Transit encryption is the process of encrypting information as it moves between two endpoints. This is important because it protects the information as it is transmitted from one endpoint to another. If the information is not encrypted, it can be intercepted and read by an attacker."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
# custom:
#   id: CB_TFAWS_020
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_020

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

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.transit_encryption_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_elasticache_replication_group' 'transit_encryption_enabled' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_elasticache_replication_group' 'transit_encryption_enabled' should be set to true",
		"snippet": block,
	}
}
