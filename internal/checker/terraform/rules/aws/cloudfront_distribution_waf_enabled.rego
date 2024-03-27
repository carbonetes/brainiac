# METADATA
# title: "CloudFront Distribution should have WAF enabled"
# description: "By configuring WAF with your CloudFront distribution using Terraform, you can protect your web applications from malicious attacks, leverage predefined rules, create custom rules, have fine-grained access control, and monitor and respond to threats."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#web_acl_idp
# custom:
#   id: CB_TFAWS_074
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_074

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
	has_attribute(resource.Attributes, "web_acl_id")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_cloudfront_distribution' 'web_acl_id' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_cloudfront_distribution' 'web_acl_id' should be set.",
		"snippet": block,
	}
}