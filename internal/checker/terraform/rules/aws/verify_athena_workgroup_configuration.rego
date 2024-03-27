# METADATA
# title: "Verify that Athena Workgroup enforces configuration"
# description: "By enforcing encryption in Athena Workgroups, organizations can safeguard sensitive data, enhance data security, and maintain compliance with rigorous security standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_workgroup#enforce_workgroup_configuration
# custom:
#   id: CB_TFAWS_076
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_076

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_athena_workgroup"
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
	some blocks in resource.Blocks
	blocks.Type == "configuration"
	blocks.Attributes.enforce_workgroup_configuration == false
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_athena_workgroup' for 'enforce_workgroup_configuration' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_athena_workgroup' for 'enforce_workgroup_configuration' should be set.",
		"snippet": block,
	}
}