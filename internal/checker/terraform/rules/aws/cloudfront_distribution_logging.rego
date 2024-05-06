# METADATA
# title: "Verify that Ensure Cloudfront distribution has Access Logging enabled"
# description: "By enabling access logging for the CloudFront distribution, you can capture detailed information about the requests made to your content delivery network, allowing for better analysis and monitoring."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#logging_config
# custom:
#   id: CB_TFAWS_092
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_092

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudfront_distribution"
}

has_attribute(key, value) if {
	value in object.keys(key)
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
	some block in resource.Blocks
	block.Type == "logging_config"
	has_attribute(block.Attributes, "bucket")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_cloudfront_distribution' for 'logging_config' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_cloudfront_distribution' for 'logging_config' should be set.",
		"snippet": block,
	}
}