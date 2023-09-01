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

import future.keywords.if

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

pass[resource] {
	resource := input[_]
    isvalid(resource)
    resource.Blocks[_].Type == "logging_config"
    has_attribute(resource.Blocks[_].Attributes, "bucket")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudfront_distribution' for 'logging_config' is set properly.",
                "snippet": {} }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudfront_distribution' for 'logging_config' should be set.",
                "snippet": {} }
} 