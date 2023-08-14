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

supportedResource := ["aws_route", "aws_route_table"]

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == supportedResource[_]
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.vpc_peering_connection_id != ""
	block.Attributes.destination_cidr_block != "0.0.0.0/0"
	block.Attributes.destination_cidr_block != "0.0.0.0"
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "AWS route table with VPC peering does not contain routes overly permissive to all traffic.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "AWS route table with VPC peering contains routes overly permissive to all traffic.",
		"snippet": block,
	}
}
