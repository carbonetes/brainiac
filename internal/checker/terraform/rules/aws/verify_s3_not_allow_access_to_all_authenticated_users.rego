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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_s3_bucket_acl"
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
	block.Blocks[_].Type == "access_control_policy"
	block.Blocks[_].Blocks[_].Type == "grant"
	block.Blocks[_].Blocks[_].Blocks[_].Type == "grantee"
	block.Blocks[_].Blocks[_].Blocks[_].Attributes.uri != "http://acs.amazonaws.com/groups/global/AuthenticatedUsers"
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "S3 Bucket does not allow access to all Authenticated users.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "S3 Bucket allows access to all Authenticated users.",
		"snippet": block,
	}
}
