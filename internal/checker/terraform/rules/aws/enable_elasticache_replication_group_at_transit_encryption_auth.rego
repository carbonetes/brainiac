# METADATA
# title: "Enable Encryption at transit with auth_token for ElastiCache Replication Groups"
# description: "ElastiCache Replication Groups should be encrypted at transit with auth_token to ensure that the data is not exposed to any unauthorized users."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
# custom:
#   id: CB_TFAWS_022
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_022

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_elasticache_replication_group"
}

has_attribute(key, value) if {
    value in object.keys(key)
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
    has_attribute(resource.Attributes, "auth_token")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_elasticache_replication_group' 'transit_encryption_enabled' and 'auth_token' is set properly.",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_elasticache_replication_group' 'transit_encryption_enabled' and 'auth_token' should be set to true",
                "snippet": block }
} 