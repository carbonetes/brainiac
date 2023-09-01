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
    minimumProtocolVersion := ["TLSv1.2_2018", "TLSv1.2_2019", "TLSv1.2_2021"]
    resource := input[_]
	isvalid(resource)
    viewerCertificate := resource.Blocks[_]
    viewerCertificate.Type == "viewer_certificate"
    has_attribute(resource.Blocks[_].Attributes, "minimum_protocol_version")
    resource.Blocks[_].Attributes.minimum_protocol_version == minimumProtocolVersion[_]
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "CloudFront Distribution Viewer Certificate is compliant to TLS v1.2.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "CloudFront Distribution Viewer Certificate must be compliant to TLS v1.2.",
                "snippet": block }
} 