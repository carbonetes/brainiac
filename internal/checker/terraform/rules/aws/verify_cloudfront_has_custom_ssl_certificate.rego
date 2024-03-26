# METADATA
# title: "Verify AWS CloudFront distribution uses custom SSL certificate."
# description: "This policy aims to ensure the enhanced security and data privacy of content delivery through Amazon Web Services (AWS) CloudFront by verifying that each CloudFront distribution is configured to use a custom SSL certificate."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
# custom:
#   id: CB_TFAWS_324
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_324

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
	some inner in block.Blocks
	inner.Type == "viewer_certificate"
	inner.Attributes.iam_certificate_id != ""
}

pass contains block if {
	some block in input
	isvalid(block)
	some inner in block.Blocks
	inner.Type == "viewer_certificate"
	inner.Attributes.acm_certificate_arn != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS CloudFront distribution uses custom SSL certificate.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS CloudFront distribution does not use custom SSL certificate.",
		"snippet": block,
	}
}
