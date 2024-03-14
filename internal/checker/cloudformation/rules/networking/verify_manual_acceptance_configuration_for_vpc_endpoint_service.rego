# METADATA
# title: "Verify Manual Acceptance Configuration for VPC Endpoint Service"
# description: "Confirm the manual acceptance configuration for the VPC Endpoint Service."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-vpcendpointservice.html
# custom:
#   id: CB_CFT_090
#   severity: LOW
package lib.cloudformation.CB_CFT_090
import future.keywords.in

resource := "AWS::EC2::VPCEndpointService"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
    properties := resources.Properties
    properties.AcceptanceRequired == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := {
		"message": "VPC endpoint service is manually accepted.",
		"snippet": properties,
	}
}

failed[result] {
	some properties in fail
	result := {
		"message": "VPC endpoint service is not manually accepted.",
		"snippet": properties,
	}
}
