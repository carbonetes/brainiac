# METADATA
# title: "Verify viewer policy protocol is HTTPS"
# description: "This policy manages the SSL or TLS configuration for communication with viewers. It is recommended to use the ViewerProtocolPolicy parameter to enable secure HTTPS communication, focusing on viewers supporting SNI. Accepting HTTPS connections from all viewers, including those without SNI support, incurs additional charges from CloudFront."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudfront-distribution.html
# custom:
#   id: CB_CFT_024
#   severity: HIGH
package lib.cloudformation.CB_CFT_024
import future.keywords.in

resource := "AWS::CloudFront::Distribution"

is_valid{
	some resources in input.Resources
    resources.Type == resource
}

pass[protocol] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
    some protocol in properties.DistributionConfig
    protocol.ViewerProtocolPolicy == "HTTPS"
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

