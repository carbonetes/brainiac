# METADATA
# title: "Confirm that the CloudFront Distribution Viewer Certificate is TLS v1.2 compliant"
# description: "The TLS v1.2 protocol provides strong security for communication between clients and the CloudFront Distribution, helping to protect sensitive data and mitigate potential vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
# custom:
#   id: CB_TFAWS_166
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_166
import rego.v1

isvalid(block) if{
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

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
    some resource in input
	isvalid(resource)
    min_protocol_ver := ["TLSv1.2_2018", "TLSv1.2_2019", "TLSv1.2_2021"]
    some block in resource.Blocks
    block.Type == "viewer_certificate"
    has_attribute(block.Attributes, "minimum_protocol_version")
    block.Attributes.minimum_protocol_version in min_protocol_ver
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "CloudFront Distribution Viewer Certificate is compliant to TLS v1.2.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "CloudFront Distribution Viewer Certificate must be compliant to TLS v1.2.",
                "snippet": block }
} 