# METADATA
# title: "Verify DB Snapshots are not Public"
# description: "Verifying that DB snapshots are not public ensures data protection, compliance, cost optimization, prevention of data leaks, data recovery control, and data integrity."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_snapshot#shared_accounts
# custom:
#   id: CB_TFAWS_280
#   severity: HIGH
package lib.terraform.CB_TFAWS_280

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_db_snapshot"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.shared_accounts == "all"
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	some test in resource.Attributes.shared_accounts
	test == "all"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_db_snapshot' shared_accounts is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_db_snapshot' shared_accounts should not be set to 'all'.",
		"snippet": block,
	}
}
