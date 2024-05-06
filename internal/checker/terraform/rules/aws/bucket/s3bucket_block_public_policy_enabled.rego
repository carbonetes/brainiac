# METADATA
# title: "Verify S3 bucket has block public policy enabled"
# description: "By blocking public policies, you reduce the risk of unauthorized access to sensitive data that may be stored in the S3 bucket."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block#block_public_policy
# custom:
#   id: CB_TFAWS_051
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_051

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
	resource.Attributes.block_public_policy == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_s3_bucket_public_access_block' 'block_public_policy' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_s3_bucket_public_access_block' 'block_public_policy' should be set to true",
		"snippet": block,
	}
}
