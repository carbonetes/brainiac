# METADATA
# title: "Verify Security Groups description"
# description: "This policy suggests adding descriptive text to each Security Group Rule to clarify its intended goals, thereby mitigating potential developer errors."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-securitygroup.html
# custom:
#   id: CB_CFT_013
#   severity: LOW
package lib.cloudformation.CB_CFT_013

import future.keywords.in

resource := "AWS::EC2::SecurityGroup"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[ingress] {
	is_valid
	some resources in input.Resources
	some ingress in resources.Properties.SecurityGroupIngress
	not "Description" in object.keys(ingress)
}

fail[egress] {
	is_valid
	some resources in input.Resources
	some egress in resources.Properties.SecurityGroupEgress
	not "Description" in object.keys(egress)
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
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
