# METADATA
# title: "Verify Security Groups allowing ingress from 0.0.0.0/0 to port 80"
# description: "This policy discourages allowing ingress from 0.0.0.0/0 to port 80, as it exposes AWS resources to potential security threats. To mitigate risks, specify allowed IP addresses or ranges and restrict traffic accordingly."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-securitygroup.html
# custom:
#   id: CB_CFT_116
#   severity: LOW
package lib.cloudformation.CB_CFT_116

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
	ingress.FromPort == 80
	ingress.ToPort == 80
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
		"message": "No Security groups allow ingress from 0.0.0.0/0 to port 80",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Security groups allow ingress from 0.0.0.0/0 to port 80",
		"snippet": block,
	}
}
