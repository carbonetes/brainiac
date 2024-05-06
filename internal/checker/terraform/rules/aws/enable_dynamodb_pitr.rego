# METADATA
# title: "Enable point_in_time_recovery for DynamoDB tables"
# description: "This checks whether point_in_time_recovery is enabled for DynamoDB tables."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
# custom:
#   id: CB_TFAWS_016
#   severity: HIGH
package lib.terraform.CB_TFAWS_016

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_dynamodb_table"
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
	some index
	some resource in input
	isvalid(resource)
	resource.Blocks[index].Type == "point_in_time_recovery"
	resource.Blocks[index].Attributes.enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_dynamodb_table' 'point_in_time_recovery' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_dynamodb_table' 'point_in_time_recovery' must be set to true.",
		"snippet": block,
	}
}
