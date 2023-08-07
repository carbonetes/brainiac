# METADATA
# title: "Verify Transit Gateways do not automatically accept VPC attachment requests"
# description: "This policy aims to ensure the heightened security of Amazon Web Services (AWS) Transit Gateways by verifying that they are not configured to automatically accept Virtual Private Cloud (VPC) attachment requests."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway.html
# custom:
#   id: CB_TFAWS_313
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_313

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_ec2_transit_gateway"
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
	block.Attributes.auto_accept_shared_attachments != "enable"
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "Transit Gateways does not automatically accept VPC attachment requests.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "Transit Gateways automatically accepts VPC attachment requests.",
		"snippet": block,
	}
}
