# METADATA
# title: "Verify Cloudtrail are enabled to all regions"
# description: "This policy enables AWS CloudTrail to record API calls within your account, providing essential details like caller identity, timestamps, and request parameters. It supports security analysis, resource tracking, and compliance auditing. Additionally, it ensures multi-region security by detecting unusual activities, enabling global service logging, and capturing management actions across all resources."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudtrail-trail.html
# custom:
#   id: CB_CFT_049
#   severity: LOW
package lib.cloudformation.CB_CFT_049
import future.keywords.in

resource := "AWS::CloudTrail::Trail"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	enabled := properties
    enabled.IsMultiRegionTrail == true
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Cloudtrail is enabled to all regions",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cloudtrail not enabled to all regions",
		"snippet": block,
	}
}
