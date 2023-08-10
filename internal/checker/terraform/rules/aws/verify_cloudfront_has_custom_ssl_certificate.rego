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

isIAMCertificateExists {
	block := input[_]
	block.Type == "resource"
	block.Blocks[_].Type == "viewer_certificate"
	block.Blocks[_].Attributes.iam_certificate_id
}

isACMCertificateExists {
	block := input[_]
	block.Type == "resource"
	block.Blocks[_].Type == "viewer_certificate"
	block.Blocks[_].Attributes.acm_certificate_arn
}

pass[block] {
	block := input[_]
	isvalid(block)
	isIAMCertificateExists
}

pass[block] {
	block := input[_]
	isvalid(block)
	isACMCertificateExists
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
