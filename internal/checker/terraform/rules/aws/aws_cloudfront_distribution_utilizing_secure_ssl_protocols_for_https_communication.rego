# METADATA
# title: "Guarantee the adoption of secure SSL protocols for HTTPS communication within the AWS CloudFront distribution"
# description: "Enhance the security of AWS CloudFront distribution by configuring robust SSL protocols to establish a secure channel for HTTPS communication."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
# custom:
#   id: CB_TFAWS_361
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_361

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
	some resource in input
	isvalid(resource)
	some origin in resource.Blocks
	origin.Type == "origin"
	some custom_origin_config in origin.Blocks
	custom_origin_config.Type == "custom_origin_config"
	"SSLv3" in custom_origin_config.Attributes.origin_ssl_protocols
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "SSL protocols for HTTPS communication is utilized within the AWS CloudFront distribution.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "SSL protocols for HTTPS communication must be utilized within the AWS CloudFront distribution.",
		"snippet": block,
	}
}
