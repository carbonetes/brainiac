# METADATA
# title: "Verify AWS Cloudfront Distribution with S3 have Origin Access set to enabled"
# description: "This policy aims to ensure the proper configuration and access control of Amazon Web Services (AWS) CloudFront distributions associated with Amazon S3 origins by verifying that Origin Access Identity (OAI) is enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
# custom:
#   id: CB_TFAWS_345
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_345

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudfront_distribution"
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
    some origin in block.Blocks
    origin.Type == "origin"
    some s3_origin_config in origin.Blocks
    s3_origin_config.Type == "s3_origin_config"
}

pass contains block if {
	some block in input
	isvalid(block)
	some origin in block.Blocks
	origin.Type == "origin"
	origin.Attributes.origin_access_control_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The AWS CloudFront Distribution with S3 has Origin Access successfully enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The AWS CloudFront Distribution with S3 failed to enable Origin Access.",
		"snippet": block,
	}
}
