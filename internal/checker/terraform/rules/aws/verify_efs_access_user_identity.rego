# METADATA
# title: "Verify EFS access points should enforce a user identity"
# description: "This policy is designed to ensure that all Amazon Elastic File System (EFS) access points enforce a user identity. Enforcing a user identity enhances security and access control by associating file system operations with specific users and groups, thereby preventing unauthorized access to sensitive data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.5.0/docs/resources/efs_access_point#posix_user
# custom:
#   id: CB_TFAWS_305
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_305

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
	block.Blocks[_].Type == "posix_user"
	block.Blocks[_].Attributes.gid != ""
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "EFS access points have been configured to enforce a user identity.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "EFS access points are not configured to enforce a user identity.",
		"snippet": block,
	}
}
