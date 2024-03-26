# METADATA
# title: "Verify that ElastiCache clusters do not use the default subnet group"
# description: "By specifying a custom subnet group for the ElastiCache cluster, we ensure optimal network placement and security, enhancing performance and isolation within the AWS infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster
# custom:
#   id: CB_TFAWS_311
#   severity: LOW
package lib.terraform.CB_TFAWS_311

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
	resource.Attributes.subnet_group_name != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "ElastiCache clusters does not use the default subnet group.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "ElastiCache clusters should not use the default subnet group.",
		"snippet": block,
	}
}
