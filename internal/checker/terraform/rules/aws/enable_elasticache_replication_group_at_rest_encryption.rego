# METADATA
# title: "Enable encryption at rest for ElastiCache Replication Groups"
# description: "ElastiCache Replication Groups should have encryption at rest enabled to protect sensitive data. By default, ElastiCache Replication Groups are not encrypted at rest. This can be remediated by setting the at_rest_encryption_enabled attribute to true."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group
# custom:
#   id: CB_TFAWS_017
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_017

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
    resource.Attributes.at_rest_encryption_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_elasticache_replication_group' 'at_rest_encryption_enabled' is set properly.",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_elasticache_replication_group' 'at_rest_encryption_enabled' should be set to true",
                "snippet": block }
} 