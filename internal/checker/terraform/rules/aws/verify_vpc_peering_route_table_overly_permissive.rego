# METADATA
# title: "Verify AWS route table with VPC peering does not contain routes overly permissive to all traffic"
# description: "This policy is designed to ensure the secure configuration of Amazon Web Services (AWS) route tables associated with Virtual Private Cloud (VPC) peering connections by verifying that routes do not overly permit all traffic."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
# custom:
#   id: CB_TFAWS_333
#   severity: HIGH
package lib.terraform.CB_TFAWS_333

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_route", "aws_route_table"]
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

fail contains block if {
	some block in input
	isvalid(block)
	some inner in block.Blocks
	inner.Type == "route"
	inner.Attributes.vpc_peering_connection_id != ""
	checkCidrIfFail(inner.Attributes.cidr_block)
}

fail contains block if {
	some block in input
	isvalid(block)
	some inner in block.Blocks
	inner.Type == "route"
	inner.Attributes.vpc_peering_connection_id != ""
	checkV6CidrIfFail(inner.Attributes.ipv6_cidr_block)
}

fail contains block if {
	some block in input
	isvalid(block)
	block.Attributes.vpc_peering_connection_id != ""
	checkCidrIfFail(block.Attributes.destination_cidr_block)
}

fail contains block if {
	some block in input
	isvalid(block)
	block.Attributes.vpc_peering_connection_id != ""
	checkV6CidrIfFail(block.Attributes.destination_ipv6_cidr_block)
}

checkCidrIfFail(attribute) := result if {
	attribute == "0.0.0.0/0"
	result := true
} else := result if {
	attribute == "0.0.0.0"
	result := true
} else := result if {
	result := false
}

checkV6CidrIfFail(attribute) := result if {
	attribute == "::0"
	result := true
} else := result if {
	attribute == "::/0"
	result := true
} else := result if {
	result := false
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS route table with VPC peering does not contain routes overly permissive to all traffic.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS route table with VPC peering contains routes overly permissive to all traffic.",
		"snippet": block,
	}
}
