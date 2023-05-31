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
    resource.Blocks[index].Type == "default_cache_behavior"
    resource.Blocks[index].Attributes.viewer_protocol_policy == "allow-all"
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[index].Type == "ordered_cache_behavior"
    resource.Blocks[index].Attributes.viewer_protocol_policy == "allow-all"
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudfront_distribution' 'default_cache_behavior' and 'ordered_cache_behavior' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudfront_distribution' 'default_cache_behavior' and 'ordered_cache_behavior' should not use 'allow-all'.",
                "snippet": block }
} 