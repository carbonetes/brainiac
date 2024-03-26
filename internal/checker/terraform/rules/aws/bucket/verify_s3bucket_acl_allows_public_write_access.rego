# METADATA
# title: "S3 Bucket has an ACL defined which allows public WRITE access."
# description: "This is a security risk that should be addressed to prevent unauthorized data modifications and potential financial implications."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl
# custom:
#   id: CB_TFAWS_055
#   severity: HIGH
package lib.terraform.CB_TFAWS_055

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_s3_bucket", "aws_s3_bucket_acl"]
	label in supportedresource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.acl == "public-read-write"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_s3_bucket_acl' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_s3_bucket_acl' should not be set with write access.",
		"snippet": block,
	}
}