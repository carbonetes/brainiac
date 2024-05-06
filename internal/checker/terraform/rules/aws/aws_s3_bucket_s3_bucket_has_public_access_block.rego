# METADATA
# title: "A Public Access block must be present in the S3 bucket"
# description: "Setting the extra resource aws_s3_bucket_public_access_block when creating an S3 bucket is recommended to make sure the bucket is never unintentionally made public."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket.html
# custom:
#   id: CB_TFAWS_328
#   severity: LOW
package lib.terraform.CB_TFAWS_328

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_s3_bucket"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_s3_bucket_public_access_block" in resource.Labels
	resource.Attributes.block_public_acls == true
	resource.Attributes.block_public_policy == true
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Public Access block is present in the S3 bucket.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Public Access block must be present in the S3 bucket.",
		"snippet": block,
	}
}
