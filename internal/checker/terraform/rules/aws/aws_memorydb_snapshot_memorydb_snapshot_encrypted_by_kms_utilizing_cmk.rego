# METADATA
# title: "A customer managed Key (CMK) should be used to encrypt the MemoryDB snapshot"
# description: "This quick test verifies that the MemoryDB snapshot encrypts its contents with AWS key management - KMS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/figma/aws-4-49-0/latest/docs/resources/memorydb_snapshot
# custom:
#   id: CB_TFAWS_259
#   severity: HIGH
package lib.terraform.CB_TFAWS_259

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_memorydb_snapshot"
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
	has_attribute(resource.Attributes, "kms_key_arn")
	resource.Attributes.kms_key_arn != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Customer Managed Key (CMK) is used to encrypt the MemoryDB snapshot.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Customer Managed Key (CMK) must be used to encrypt the MemoryDB snapshot.",
		"snippet": block,
	}
}
