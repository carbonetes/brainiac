# METADATA
# title: "Verify Cloudfront distribution has a default root object configured"
# description: "Verifying that a CloudFront distribution has a default root object configured ensures a seamless user experience by presenting a specific file as the default page when visitors access the root URL."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution.html
# custom:
#   id: CB_TFAWS_287
#   severity: LOW
package lib.terraform.CB_TFAWS_287

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

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.default_root_object != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_cloudfront_distribution' default_root_object is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_cloudfront_distribution' default_root_object must be set.",
		"snippet": block,
	}
}
