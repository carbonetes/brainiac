# METADATA
# title: "Route53 A Record has Attached Resource"
# description: "This policy focuses on verifying that A records are linked to the intended resources, often using alias names, and adhere to predefined naming conventions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record.html#attribute-reference
# custom:
#   id: CB_TFAWS_319
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_319

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_route53_record"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.type == "A"
	some block in resource.Blocks
	block.Type == "alias"
	valid_values := ["module", "data.", "var."]
	some valid in valid_values
	contains(block.Attributes.name, valid)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Route53 A Record has Attached Resource.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Route53 A Record should have Attached Resource.",
		"snippet": block,
	}
}
