# METADATA
# title: "Verify EFS access points should enforce a root directory"
# description: "This policy aims to ensure the secure configuration of Amazon Elastic File System (EFS) access points by verifying that each access point enforces a designated root directory."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.5.0/docs/resources/efs_access_point
# custom:
#   id: CB_TFAWS_303
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_303

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_efs_access_point"
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
	some root_dir in block.Blocks
	root_dir.Type == "root_directory"
	root_dir.Attributes.path != "/"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "EFS access points have been configured to enforce a root directory.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "EFS access points are not configured to enforce a root directory.",
		"snippet": block,
	}
}
