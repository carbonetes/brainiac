# METADATA
# title: "Check to see if Security Groups are linked to another resource"
# description: "You can decide which traffic is allowed to pass through your EC2 instances and which traffic is restricted by adding security groups to your ENIs or EC2 instances."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group.html
# custom:
#   id: CB_TFAWS_323
#   severity: LOW
package lib.terraform.CB_TFAWS_323

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_security_group"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getawssecuritygrouplabel contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_security_group" in resource.Labels
	label := concat(".", resource.Labels)
}

valid_connected_resources := ["aws_network_interface", "aws_instance"]

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	some label_resource in resource.Labels
	label_resource in valid_connected_resources
	some label in getawssecuritygrouplabel
	startswith(resource.Attributes.security_groups, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Security Groups are linked to another resource.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Security Groups must be linked to another resource.",
		"snippet": block,
	}
}
