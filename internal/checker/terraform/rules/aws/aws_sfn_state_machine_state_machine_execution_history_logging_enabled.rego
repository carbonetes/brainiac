# METADATA
# title: "Guarantee that the State Machine has active execution history logging"
# description: "Enforce logging of execution history for State Machines to track and monitor workflow execution events effectively."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine.html
# custom:
#   id: CB_TFAWS_268
#   severity: HIGH
package lib.terraform.CB_TFAWS_268

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_sfn_state_machine"
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
	some block in resource.Blocks
	block.Type == "logging_configuration"
	has_attribute(block.Attributes, "include_execution_data")
	block.Attributes.include_execution_data == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS State Machine has execution history logging activated.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS State Machine must have execution history logging activated.",
		"snippet": block,
	}
}
