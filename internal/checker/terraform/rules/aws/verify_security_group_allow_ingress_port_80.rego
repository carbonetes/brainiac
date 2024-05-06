# METADATA
# title: "Verify no security groups allow ingress from 0.0.0.0:0 to port 80"
# description: "By restricting inbound access to port 80, which is commonly used for HTTP web traffic, only to specific trusted sources, it reduces the risk of unauthorized access or potential security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.56.0/docs/resources/security_group#ingress
# custom:
#   id: CB_TFAWS_252
#   severity: HIGH
package lib.terraform.CB_TFAWS_252

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_security_group", "aws_security_group_rule", "aws_vpc_security_group_ingress_rule"]
	label in supported_resources
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
	"0.0.0.0/0" in block.Attributes.cidr_blocks
	to_number(resource.Blocks[_].Attributes.from_port) == 80
}

passed contains result if {
	some block in pass
	result := {
		"message": "No security groups allow ingress from 0.0.0.0:0 to port 80",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_security_group must not allow ingress from 0.0.0.0:0 to port 80.",
		"snippet": block,
	}
}
