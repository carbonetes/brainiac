# METADATA
# title: "Verify Cloudfront distribution is enabled"
# description: "By verifying that the CloudFront distribution is enabled, this policy helps ensure that your content is being efficiently distributed and delivered to end users."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#enabled
# custom:
#   id: CB_TFAWS_202
#   severity: LOW
package lib.terraform.CB_TFAWS_202

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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Cloudfront distribution is enabled",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Cloudfront distribution should be enabled",
                "snippet": block }
} 