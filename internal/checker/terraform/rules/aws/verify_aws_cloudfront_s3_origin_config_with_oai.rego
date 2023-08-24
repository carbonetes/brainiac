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
	block.Blocks[_].Type == "origin"
	block.Blocks[_].Blocks[_].Type == "s3_origin_config"
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Blocks[_].Type == "origin"
	block.Blocks[_].Blocks[_].Attributes.origin_access_control_id != ""
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "The AWS CloudFront Distribution with S3 has Origin Access successfully enabled.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "The AWS CloudFront Distribution with S3 failed to enable Origin Access.",
		"snippet": block,
	}
}
