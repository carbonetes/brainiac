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
	some posix in block.Blocks
	posix.Type == "posix_user"
	posix.Attributes.gid != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "EFS access points have been configured to enforce a user identity.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "EFS access points are not configured to enforce a user identity.",
		"snippet": block,
	}
}
