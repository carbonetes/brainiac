# METADATA
# title: "Verify RDS instance with copy tags to snapshots is enabled"
# description: "Enabling this feature helps maintain consistent metadata and context between the RDS instances and their snapshots."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#copy_tags_to_snapshot
# custom:
#   id: CB_TFAWS_360
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_360

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_db_instance"
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
	resource.Attributes.copy_tags_to_snapshot == true
	invalid_engines := ["neptune", "aurora", "docdb"]
	not resource.Attributes.engine in invalid_engines
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "RDS instance copy tags to snapshots is enabled",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "RDS instance copy tags to snapshots should be enabled.",
		"snippet": block,
	}
}
