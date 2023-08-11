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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_cloudfront_distribution"
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
	innerBlock := block.Blocks[_]
	innerBlock.Type == "viewer_certificate"
	innerBlock.Attributes.iam_certificate_id != ""
}

pass[block] {
	block := input[_]
	isvalid(block)
	innerBlock := block.Blocks[_]
	innerBlock.Type == "viewer_certificate"
	innerBlock.Attributes.acm_certificate_arn != ""
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "AWS CloudFront distribution uses custom SSL certificate.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "AWS CloudFront distribution does not use custom SSL certificate.",
		"snippet": block,
	}
}
