# METADATA
# title: "Verify that cloudfront distribution ViewerProtocolPolicy is not set to allow-all"
# description: "An Amazon CloudFront distribution can be configured to accept only HTTPS requests by setting the ViewerProtocolPolicy element to https-only. If the ViewerProtocolPolicy element is set to allow-all, the Amazon CloudFront distribution accepts both HTTP and HTTPS requests. This is not recommended because it reduces the security of the distribution."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
# custom:
#   id: CB_TFAWS_031
#   severity: LOW
package lib.terraform.CB_TFAWS_031

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

fail contains resource if {
	some index
	some resource in input
	isvalid(resource)
	resource.Blocks[index].Type == "default_cache_behavior"
	resource.Blocks[index].Attributes.viewer_protocol_policy == "allow-all"
}

fail contains resource if {
	some index
	some resource in input
	isvalid(resource)
	resource.Blocks[index].Type == "ordered_cache_behavior"
	resource.Blocks[index].Attributes.viewer_protocol_policy == "allow-all"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_cloudfront_distribution' 'default_cache_behavior' and 'ordered_cache_behavior' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_cloudfront_distribution' 'default_cache_behavior' and 'ordered_cache_behavior' should not use 'allow-all'.",
		"snippet": block,
	}
}
