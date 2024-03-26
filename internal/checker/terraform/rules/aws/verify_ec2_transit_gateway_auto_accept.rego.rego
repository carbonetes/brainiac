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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ec2_transit_gateway"
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
	block.Attributes.auto_accept_shared_attachments != "enable"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Transit Gateways does not automatically accept VPC attachment requests.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Transit Gateways automatically accepts VPC attachment requests.",
		"snippet": block,
	}
}
