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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_cloudfront_distribution"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
    some resource in input
	isvalid(resource)
    resource.Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Cloudfront distribution is enabled",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Cloudfront distribution should be enabled",
                "snippet": block }
} 