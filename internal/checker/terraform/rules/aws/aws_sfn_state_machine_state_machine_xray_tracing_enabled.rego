# METADATA
# title: "Verify that the State Machine includes active X-Ray tracing functionality"
# description: "This check verifies if the AWS State Machine has X-Ray tracing activated. X-Ray tracing provides valuable insights into the State Machine's execution, aiding in debugging and optimizing performance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sfn_state_machine.html
# custom:
#   id: CB_TFAWS_267
#   severity: HIGH
package lib.terraform.CB_TFAWS_267

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
	block.Type == "tracing_configuration"
	has_attribute(block.Attributes, "enabled")
	block.Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS State Machine has X-Ray tracing activated.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS State Machine must have X-Ray tracing activated.",
		"snippet": block,
	}
}
