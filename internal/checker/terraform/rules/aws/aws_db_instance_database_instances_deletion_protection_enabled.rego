# METADATA
# title: "Verify that deletion protection is activated for AWS database instances"
# description: "This check verifies that AWS database instances have deletion protection enabled, which adds an extra layer of security by preventing accidental deletions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/db_instance.html
# custom:
#   id: CB_TFAWS_273
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_273

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_db_instance"
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

pass contains resource if {
	some resource in input
	isvalid(resource)
	has_attribute(resource.Attributes, "deletion_protection")
	resource.Attributes.deletion_protection == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Deletion protection for AWS database instances is activated.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Deletion protection for AWS database instances must be activated.",
		"snippet": block,
	}
}
