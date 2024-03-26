# METADATA
# title: "Verify that EC2 Auto Scaling groups use EC2 launch templates"
# description: "By utilizing an EC2 launch template for Auto Scaling groups in Terraform, you can ensure consistent and efficient deployment of instances, simplifying maintenance and enhancing scalability in AWS infrastructure management."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
# custom:
#   id: CB_TFAWS_297
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_297

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_autoscaling_group"
}

has_attribute(key, value) if {
	value in object.keys(key)
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Blocks[_].Type == "launch_template"
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed contains result if {
	some block in pass
	result := {
		"message": "EC2 Auto Scaling groups is using EC2 launch templates.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "EC2 Auto Scaling groups should use EC2 launch templates.",
		"snippet": block,
	}
}
