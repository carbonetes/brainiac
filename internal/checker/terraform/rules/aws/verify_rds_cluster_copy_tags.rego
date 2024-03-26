# METADATA
# title: "Verify that RDS cluster configured to copy tags to snapshots"
# description: "By enabling the `copy_tags_to_snapshot` property in the AWS RDS Cluster configuration, it ensures that critical metadata and context provided by tags are retained during snapshot creation, facilitating better management, and enhancing data recovery processes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster
# custom:
#   id: CB_TFAWS_296
#   severity: LOW
package lib.terraform.CB_TFAWS_296

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_rds_cluster"
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
	resource.Attributes.copy_tags_to_snapshot == true
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "RDS cluster configured to copy tags to snapshots.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "RDS cluster must be configured to copy tags to snapshots.",
		"snippet": block,
	}
}
