# METADATA
# title: "Verify AWS NAT Gateways are utilized for the default route"
# description: "This practice ensures that outbound traffic from private resources flows through a secure and managed NAT Gateway, providing reliable connectivity while preventing direct exposure to the public internet."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route.html
# custom:
#   id: CB_TFAWS_337
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_337

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	valid_resources := ["aws_route", "aws_route_table"]
	label in valid_resources
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
	inner.Attributes.instance_id != ""
	inner.Attributes.cidr_block == "0.0.0.0/0"
}

fail contains block if {
	some block in input
	isvalid(block)
	block.Attributes.instance_id != ""
	block.Attributes.destination_cidr_block == "0.0.0.0/0"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS NAT Gateways are utilized for the default route",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS NAT Gateways should be utilized for the default route.",
		"snippet": block,
	}
}
