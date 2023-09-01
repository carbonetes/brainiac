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

isvalid(block){
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

fail[resource]{
    resource := input[_]
    isvalid(resource)
    resource.Blocks[_].Type == "origin"
    resource.Blocks[_].Blocks[_].Type == "custom_origin_config"
    resource.Blocks[_].Blocks[_].Attributes.origin_ssl_protocols[_] == "SSLv3"
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "SSL protocols for HTTPS communication is utilized within the AWS CloudFront distribution.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "SSL protocols for HTTPS communication must be utilized within the AWS CloudFront distribution.",
                "snippet": block }
} 