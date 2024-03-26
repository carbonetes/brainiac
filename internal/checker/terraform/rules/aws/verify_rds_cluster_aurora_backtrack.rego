# METADATA
# title: "Verify RDS Aurora Clusters have backtracking enabled"
# description: "This policy is designed to verify whether Amazon RDS Aurora Clusters have backtracking enabled. Backtracking is a valuable feature that allows the database to be restored to a previous point in time, enabling recovery from unintended data changes or issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance.html#engine
# custom:
#   id: CB_TFAWS_298
#   severity: HIGH
package lib.terraform.CB_TFAWS_298

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_rds_cluster"
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
	supported_engines := ["aurora", "aurora-mysql"]
	block.Attributes.engine in supported_engines
	to_number(block.Attributes.backtrack_window) != 0
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "RDS Aurora Clusters have backtracking enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "RDS Aurora Clusters' backtracking must be enabled.",
		"snippet": block,
	}
}
