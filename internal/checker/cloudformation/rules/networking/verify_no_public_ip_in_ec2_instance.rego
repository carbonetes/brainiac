# METADATA
# title: "Verify no public IP in EC2 instance."
# description: "This policy advises carefully controlling the assignment of public IP addresses to instances based on specific needs and requirements. By evaluating the necessity of public IP addresses for each instance, you can optimize resource allocation and enhance security by limiting exposure to the Internet only where necessary."
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-instance.html
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html
# custom:
#   id: CB_CFT_064
#   severity: HIGH
package lib.cloudformation.CB_CFT_064
import future.keywords.in

is_valid {
	supported_resources := ["AWS::EC2::Instance", "AWS::EC2::LaunchTemplate"]
	some resources in input.Resources
	resources.Type in supported_resources
}

resource[type] {
	some resource in input.Resources
	is_valid
	count(fail) > 0
	type := resource.Type
}

resource[type] {
	some resource in input.Resources
	is_valid
	count(pass) > 0
	type := resource.Type
}

fail[instance] {
	is_valid
	some resources in input.Resources
    instance := resources.Properties
    some assoc_pub in instance.NetworkInterfaces
    assoc_pub.AssociatePublicIpAddress == true
}

fail[launch] {
    is_valid
	some resources in input.Resources
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
