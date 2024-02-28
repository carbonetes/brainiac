# METADATA
# title: "Verify Security Groups description"
# description: "Checks if the security groups have a description"
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-securitygroup.html
# custom:
#   id: CB_CFT_013
#   severity: LOW
package lib.cloudformation.CB_CFT_013

import future.keywords.in

resource := ["AWS::EC2::SecurityGroup", "AWS::EC2::SecurityGroupIngress", "AWS::EC2::SecurityGroupEgress"]

is_valid {
	some resources in input.Resources
	some resource_type in resource
	resources.Type == resource_type
}

pass[block] {
	is_valid
	some resources in input.Resources
	some ingress in resources.Properties.SecurityGroupIngress
	ingress.Description != ""
	some egress in resources.Properties.SecurityGroupEgress
	egress.Description != ""
	block := {ingress, egress}
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Security Groups have a description",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Security Groups does not have a description",
		"snippet": block,
	}
}
