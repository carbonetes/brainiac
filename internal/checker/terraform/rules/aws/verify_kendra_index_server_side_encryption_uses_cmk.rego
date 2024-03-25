# METADATA
# title: "Verify Kendra index Server side encryption uses CMK"
# description: "By utilizing a CMK, you can have granular control over the encryption keys and their lifecycle, ensuring better security for your Kendra indexes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/kendra_index
# custom:
#   id: CB_TFAWS_255
#   severity: LOW
package lib.terraform.CB_TFAWS_255

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_kendra_index"
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
	some encryption in resource.Blocks
	encryption.Type == "server_side_encryption_configuration"
	encryption.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Kendra index Server side encryption uses CMK.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Kendra index Server side encryption must use CMK.",
		"snippet": block,
	}
}
