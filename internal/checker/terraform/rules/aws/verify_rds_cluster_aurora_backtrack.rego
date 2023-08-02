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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_rds_cluster"
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
	supportedEngines := ["aurora", "aurora-mysql"]
	block.Attributes.engine == supportedEngines[_]
	to_number(block.Attributes.backtrack_window) != 0
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "RDS Aurora Clusters have backtracking enabled.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "RDS Aurora Clusters' backtracking must be enabled.",
		"snippet": block,
	}
}
