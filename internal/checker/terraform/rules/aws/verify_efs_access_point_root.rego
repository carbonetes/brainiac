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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_efs_access_point"
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
	block.Blocks[_].Attributes.path != "/"
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "EFS access points have been configured to enforce a root directory.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "EFS access points are not configured to enforce a root directory.",
		"snippet": block,
	}
}
