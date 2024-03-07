# METADATA
# title: "Verify no public IP in EC2 instance."
# description: "Confirm that an EC2 instance has no public IP address assigned for enhanced security."
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-instance.html
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html
# custom:
#   ID: CB_CFT_069
#   Severity: HIGH
package lib.cloudformation.CB_CFT_069
import future.keywords.in

resource := ["AWS::EC2::Instance", "AWS::EC2::LaunchTemplate"]

is_valid {
	some resources in input.Resources
	resources.Type in resource
}

fail[instance] {
	is_valid
	some resources in input.Resources
    resources.Type in resource
    instance := resources.Properties
    some assoc_pub in instance.NetworkInterfaces
    assoc_pub.AssociatePublicIpAddress == true
}

fail[launch] {
    is_valid
	some resources in input.Resources
    resources.Type in resource
    launch := resources.Properties.LaunchTemplateData
    some assoc_pub in launch.NetworkInterfaces
	assoc_pub.AssociatePublicIpAddress == true
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "No public IP in EC2 instance",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Public IP exist in EC2 instance",
		"snippet": block,
	}
}
