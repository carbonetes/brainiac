# METADATA
# title: "Verify CloudFront Distribution Viewer Certificate is using TLS v1.2"
# description: "This policy detects AWS CloudFront web distributions using TLS versions for secure communication and recommends setting a minimum protocol of TLSv1.1_2016 or later for enhanced security."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-distribution.html
# custom:
#   id: CB_CFT_109
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_109

import future.keywords.in

resource := "AWS::CloudFront::Distribution"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties.DistributionConfig.ViewerCertificate
	values := ["TLSv1.2_2018", "TLSv1.2_2019", "TLSv1.2_2021"]
	block.MinimumProtocolVersion in values
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "CloudFront Distribution Viewer Certificate is using TLS v1.2.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "CloudFront Distribution Viewer Certificate should use TLS v1.2.",
		"snippet": block,
	}
}
