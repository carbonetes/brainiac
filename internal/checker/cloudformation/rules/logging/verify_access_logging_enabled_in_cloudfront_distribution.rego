# METADATA
# title: "Verify logging access is enabled in CloudFront Distribution"
# description: "This policy highlights the importance of CloudFront access logs, which offer detailed information about web content requests. These logs aid in security audits and can be used for analytics. Pairing CloudFront logs with Lambda and WAF logs can expedite response times and potentially block requests from suspicious IP addresses, indicating possible attack attempts."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-distribution.html
# custom:
#   id: CB_CFT_062
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_062
import future.keywords.in

resource := "AWS::CloudFront::Distribution"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	block := resources.Properties.DistributionConfig.Logging
    block.Bucket != ""
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "CloudFront Distribution have access logging enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "CloudFront Distribution have no access logging enabled",
		"snippet": block,
	}
}
