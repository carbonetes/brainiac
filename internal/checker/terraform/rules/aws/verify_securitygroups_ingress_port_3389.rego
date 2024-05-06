# METADATA
# title: "Verify no security groups allow ingress from 0.0.0.0:0 to port 3389"
# description: "Verifying that no security groups allow ingress from 0.0.0.0:0 to port 3389 provides a layer of protection against unauthorized access to sensitive resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# custom:
#   id: CB_TFAWS_046
#   severity: LOW
package lib.terraform.CB_TFAWS_046

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := [
		"aws_security_group",
		"aws_security_group_rule",
		"aws_vpc_security_group_ingress_rule",
	]
	label in supportedresource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	some childblock in resource.Blocks
	childblock.Type == "ingress"
	childblock.Attributes.to_port == "3389"
	some cidr in childblock.Attributes.cidr_blocks
	cidr == "0.0.0.0/0"
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.type == "ingress"
	resource.Attributes.to_port == "3389"
	some cidr in resource.Attributes.cidr_blocks
	cidr == "0.0.0.0/0"
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.to_port == "3389"
	some cidr in resource.Attributes.cidr_blocks
	cidr == "0.0.0.0/0"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "No security groups rule allow ingress from 0.0.0.0:0 to port 3389",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "security groups rule should not allow ingress from 0.0.0.0:0 to port 3389.",
		"snippet": block,
	}
}
