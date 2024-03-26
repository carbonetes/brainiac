# METADATA
# title: "Verify S3 Bucket does not allow access to all Authenticated users"
# description: "This policy is designed to ensure the secure configuration of Amazon Simple Storage Service (S3) buckets by verifying that no bucket allows access to all authenticated users."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/-/aws/latest/docs/resources/s3_bucket_acl
# custom:
#   id: CB_TFAWS_327
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_327

import rego.v1

isvalid(block) if {
	block.Type == "resource"
    some label in block.Labels
    label == "aws_s3_bucket_acl"
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
    some access_control_policy in block.Blocks
    access_control_policy.Type == "access_control_policy"
    some grant in access_control_policy.Blocks
    grant.Type == "grant"
    some grantee in grant.Blocks
    grantee.Type == "grantee"
    grantee.Attributes.uri != "http://acs.amazonaws.com/groups/global/AuthenticatedUsers"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "S3 Bucket does not allow access to all Authenticated users.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "S3 Bucket allows access to all Authenticated users.",
		"snippet": block,
	}
}
