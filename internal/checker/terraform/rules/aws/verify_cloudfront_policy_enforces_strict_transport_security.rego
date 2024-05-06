# METADATA
# title: "Verify CloudFront response header policy enforces Strict Transport Security"
# description: "By verifying that CloudFront response header policy enforces Strict Transport Security, you can strengthen the security posture of your web applications and provide a more secure browsing experience for your users."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_response_headers_policy
# custom:
#   id: CB_TFAWS_247
#   severity: LOW
package lib.terraform.CB_TFAWS_247

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudfront_response_headers_policy"
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
	resource.Blocks[_].Type == "security_headers_config"
	resource.Blocks[_].Blocks[_].Type == "strict_transport_security"
	max_age := resource.Blocks[_].Blocks[_].Attributes.access_control_max_age_sec
	to_number(max_age) >= 31536000
	resource.Blocks[_].Blocks[_].Attributes.include_subdomains == true
	resource.Blocks[_].Blocks[_].Attributes.preload == true
	resource.Blocks[_].Blocks[_].Attributes.override == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "CloudFront response header policy enforces Strict Transport Security",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "CloudFront response header policy must enforce Strict Transport Security",
		"snippet": block,
	}
}
