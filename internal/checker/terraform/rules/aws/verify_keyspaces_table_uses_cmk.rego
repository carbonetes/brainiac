# METADATA
# title: "Verify Keyspaces Table uses CMK"
# description: "By utilizing a CMK, you gain more control over the encryption keys and their management, which enhances the security and compliance of your sensitive data stored in Keyspaces tables."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/keyspaces_table#encryption_specification
# custom:
#   id: CB_TFAWS_260
#   severity: LOW
package lib.terraform.CB_TFAWS_260

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_keyspaces_table"
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
	some block in resource.Blocks
	block.Type == "encryption_specification"
	block.Attributes.kms_key_identifier != ""
	block.Attributes.type == "CUSTOMER_MANAGED_KEY"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Keyspaces Table uses CMK.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Keyspaces Table must use CMK.",
		"snippet": block,
	}
}
