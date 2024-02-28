# METADATA
# title: "Verify Security Groups allowing ingress from 0.0.0.0:0 to port 22"
# description: "Checks if the security groups are allowing ingress from 0.0.0.0/0 to port 22"
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-securitygroup.html
# custom:
#   id: CB_CFT_014
#   severity: LOW
package lib.cloudformation.CB_CFT_014

import future.keywords.in

resource := ["AWS::EC2::SecurityGroup", "AWS::EC2::SecurityGroupIngress"]

is_valid {
	some resources in input.Resources
	some resource_type in resource
	resources.Type == resource_type
}

fail[ingress] {
	is_valid
	some resources in input.Resources
	some ingress in resources.Properties.SecurityGroupIngress
	ingress.FromPort == 22
	ingress.ToPort == 22
	ingress.CidrIp == "0.0.0.0/0"
}


pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "No Security groups allow ingress from 0.0.0.0/0 to port 22",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Security groups allow ingress from 0.0.0.0/0 to port 22",
		"snippet": block,
	}
}
