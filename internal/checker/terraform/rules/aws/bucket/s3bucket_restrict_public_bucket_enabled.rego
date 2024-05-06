# METADATA
# title: "Verify S3 bucket has 'restrict_public_bucket' enabled"
# description: "This check helps to improve the security posture of the S3 bucket and reduce the risk of data breaches or unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block#ignore_public_acls
# custom:
#   id: CB_TFAWS_053
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_053

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_s3_bucket_public_access_block"
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
	resource.Attributes.restrict_public_buckets == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_s3_bucket_public_access_block' 'restrict_public_buckets' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_s3_bucket_public_access_block' 'restrict_public_buckets' should be set to true",
		"snippet": block,
	}
}