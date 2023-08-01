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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudfront_distribution"
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
    resource.Attributes.default_root_object != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudfront_distribution' default_root_object is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_cloudfront_distribution' default_root_object must be set.",
                "snippet": block }
}
