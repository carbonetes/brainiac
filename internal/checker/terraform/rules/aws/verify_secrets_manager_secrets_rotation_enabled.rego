# METADATA
# title: "Verify Secrets Manager secrets should have automatic rotation enabled"
# description: "This prevents unauthorized access due to long-lived credentials. Automated rotation of secrets helps maintain compliance with security best practices and industry regulations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation
# custom:
#   id: CB_TFAWS_355
#   severity: HIGH
package lib.terraform.CB_TFAWS_355

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_secretsmanager_secret"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getsecretmanagerlabel contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_secretsmanager_secret" in resource.Labels
	label := concat(".", resource.Labels)
}

is_rotation_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_secretsmanager_secret_rotation" in resource.Labels
	some label in getsecretmanagerlabel
	contains(resource.Attributes.secret_id, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_rotation_attached
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
		"message": "Secrets Manager secrets should have automatic rotation enabled.",
		"snippet": block,
	}
}
