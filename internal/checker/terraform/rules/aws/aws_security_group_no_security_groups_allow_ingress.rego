# METADATA
# title: "Verify that no security groups permit incoming connections from 0.0.0.0:0 to port -1"
# description: "AWS security group enables unrestricted internet access by enabling all ingress traffic on all ports. Check to see if ports are defined appropriately."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# custom:
#   id: CB_TFAWS_253
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_253

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_security_group", "aws_security_group_rule", "aws_vpc_security_group_ingress_rule"]
	label in supported_resources
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "ingress"
	from_port := to_number(block.Attributes.from_port)
	to_port := to_number(block.Attributes.to_port)
	from_port == -1
	to_port == -1
}

passed contains result if {
	some block in pass
	result := {
		"message": "Security groups do not permit incoming connections from 0.0.0.0:0 to port -1.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Security groups must not permit incoming connections from 0.0.0.0:0 to port -1.",
		"snippet": block,
	}
}
