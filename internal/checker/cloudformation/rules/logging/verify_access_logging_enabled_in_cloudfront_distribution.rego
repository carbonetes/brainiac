# METADATA
# title: "Verify access logging enabled in CloudFront Distribution"
# description: "Ensure access logging is enabled for AWS CloudFront Distribution."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-distribution.html
# custom:
#   id: CB_CFT_067
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_067
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
    not block.Bucket == ""
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
