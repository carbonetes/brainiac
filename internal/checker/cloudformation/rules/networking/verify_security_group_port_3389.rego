# METADATA
# title: "Verify Security Groups allowing ingress from 0.0.0.0/0 to port 3389"
# description: "Exposing port 3389 to all IP addresses (0.0.0.0/0) on your AWS resources poses a security risk, as it facilitates potential unauthorized access and increases vulnerability to external threats."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-securitygroup.html
# custom:
#   id: CB_CFT_015
#   severity: LOW
package lib.cloudformation.CB_CFT_015

import future.keywords.in

is_valid {
	supported_resources := ["AWS::EC2::SecurityGroup", "AWS::EC2::SecurityGroupIngress"]
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

fail[ingress] {
	is_valid
	some resources in input.Resources
	some ingress in resources.Properties.SecurityGroupIngress
	ingress.FromPort == 3389
	ingress.ToPort == 3389
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
		"message": "No Security groups allow ingress from 0.0.0.0/0 to port 3389",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Security groups allow ingress from 0.0.0.0/0 to port 3389",
		"snippet": block,
	}
}
