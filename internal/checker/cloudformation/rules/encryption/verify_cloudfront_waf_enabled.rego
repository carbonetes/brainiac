# METADATA
# title: "Verify CloudFront Distribution WAF are enabled"
# description: "This policy enables control over traffic accessing applications by creating security rules, blocking common attacks like SQL injection and cross-site scripting. Integration with AWS CloudFront-WAF allows blocking malicious requests to the Content Delivery Network based on defined criteria in the WAF Web ACL associated with the distribution."
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-distribution.html
# custom:
#   id: CB_CFT_050
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_050
import future.keywords.in

resource := "AWS::CloudFront::Distribution"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
    config := properties.DistributionConfig
    config.WebACLId == ""
}

pass[resources] {
    resources := input.Resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Cloudfront distribution WAF are enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cloudfront distribution WAF is not enabled",
		"snippet": block,
	}
}
