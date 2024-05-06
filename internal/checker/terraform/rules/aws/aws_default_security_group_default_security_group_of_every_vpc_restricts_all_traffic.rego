# METADATA
# title: "Be certain that every VPC's default security group prohibits all traffic"
# description: "We advise users to restrict all incoming and outgoing traffic with the default security group. Every region's default VPC's default security group should be changed to adhere to this suggestion."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group.html
# custom:
#   id: CB_TFAWS_342
#   severity: LOW
package lib.terraform.CB_TFAWS_342

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_default_security_group"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getthelabelawsvpc contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_vpc" in resource.Labels
	label := concat(".", resource.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_default_security_group" in resource.Labels
	some label in getthelabelawsvpc
	contains(resource.Attributes.vpc_id, label)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
	some block in resource.Blocks
	block.Type == "ingress"
	block.Attributes.to_port
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
	some block in resource.Blocks
	block.Type == "ingress"
	block.Attributes.from_port
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
	some block in resource.Blocks
	block.Type == "ingress"
	block.Attributes.self
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
	some block in resource.Blocks
	block.Type == "ingress"
	block.Attributes.protocol
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
	some block in resource.Blocks
	block.Type == "egress"
	block.Attributes.from_port
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
	some block in resource.Blocks
	block.Type == "egress"
	block.Attributes.to_port
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
	some block in resource.Blocks
	block.Type == "egress"
	block.Attributes.cidr_blocks
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
	some block in resource.Blocks
	block.Type == "egress"
	block.Attributes.protocol
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not is_valid_resource_attached
}

pass contains block if {
	some block in input
	isvalid(block)
	is_valid_resource_attached
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Every VPC's default security group prohibits all traffic.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Every VPC's default security group must prohibit all traffic.",
		"snippet": block,
	}
}
