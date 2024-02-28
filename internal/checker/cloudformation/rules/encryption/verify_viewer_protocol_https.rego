# METADATA
# title: "Verify viewer policy protocol is HTTPS"
# description: "Utilize the ViewerProtocolPolicy parameter for secure HTTPS communication in CloudFormation. Accept HTTPS connections only from viewers supporting SNI to avoid extra charges from CloudFront."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-distribution.html
# custom:
#   id: CB_CFT_28
#   severity: HIGH
package lib.cloudformation.CB_CFT_28
import future.keywords.in

resource := "AWS::CloudFront::Distribution"

is_valid{
	some resources in input.Resources
    resources.Type == resource
}

pass[block] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
    some protocol in properties.DistributionConfig
    protocol.ViewerProtocolPolicy == "HTTPS"
    block := protocol
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "ViewerProtocolPolicy is HTTPS",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "ViewerProtocolPolicy should be set to HTTPS",
		"snippet": block,
	}
}

