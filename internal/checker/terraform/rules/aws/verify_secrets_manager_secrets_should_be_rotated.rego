# METADATA
# title: "Verify Secrets Manager secrets should be rotated within 90 days"
# description: "Verifying that Secrets Manager secrets are rotated within 90 days ensures data security by regularly refreshing sensitive information, reducing the impact of potential breaches and aligning with compliance standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation
# custom:
#   id: CB_TFAWS_285
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_285

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_secretsmanager_secret_rotation"
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
	block.Type == "rotation_rules"
	days := to_number(block.Attributes.automatically_after_days)
	days <= 90
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Secrets Manager secrets rotations is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Secrets Manager secrets should be rotated within 90 days.",
		"snippet": block,
	}
}
