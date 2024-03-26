# METADATA
# title: "Verify replicated backups are encrypted at rest using KMS CMKs"
# description: "By encrypting replicated backups at rest using KMS CMKs, sensitive data remains secure and protected from unauthorized access, ensuring compliance with data security standards and safeguarding against potential data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#storage_encrypted
# custom:
#   id: CB_TFAWS_274
#   severity: LOW
package lib.terraform.CB_TFAWS_274

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_db_instance_automated_backups_replication"
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
	resource.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Replicated backups are encrypted at rest using KMS CMKs.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Replicated backups is not encrypted at rest using KMS CMKs.",
		"snippet": block,
	}
}
