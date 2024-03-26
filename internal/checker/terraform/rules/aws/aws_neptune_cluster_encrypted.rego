# METADATA
# title: "Make sure that the neptune storage is encrypted in a secure manner"
# description: "Data and metadata stored on Neptune are shielded from unauthorized access by encryption."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/neptune/latest/userguide/encrypt-ssl-connections.html
# custom:
#   id: CB_TFAWS_025
#   severity: LOW
package lib.terraform.CB_TFAWS_025

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_neptune_cluster"
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
	resource.Attributes.storage_encrypted == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "storage_encrypted is set to true.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "storage_encrypted should be set to true.",
		"snippet": block,
	}
}
