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


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudfront_distribution"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "web_acl_id")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudfront_distribution' 'web_acl_id' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudfront_distribution' 'web_acl_id' should be set.",
                "snippet": block }
} 