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


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudfront_response_headers_policy"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "security_headers_config"
    resource.Blocks[_].Blocks[_].Type == "strict_transport_security"
    maxAge := resource.Blocks[_].Blocks[_].Attributes.access_control_max_age_sec
    to_number(maxAge) >= 31536000
    resource.Blocks[_].Blocks[_].Attributes.include_subdomains == true
    resource.Blocks[_].Blocks[_].Attributes.preload == true
    resource.Blocks[_].Blocks[_].Attributes.override == true
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "CloudFront response header policy enforces Strict Transport Security",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "CloudFront response header policy must enforce Strict Transport Security",
                "snippet": block }
}
