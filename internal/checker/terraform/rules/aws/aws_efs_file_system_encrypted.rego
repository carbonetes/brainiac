# METADATA
# title: "See to it that EFS is safely encrypted"
# description: "To prevent unwanted access to data and information, the Amazon EFS must be encrypted."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system
# custom:
#   id: CB_TFAWS_028
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_028

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_efs_file_system"
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
	resource.Attributes.encrypted == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "aws_efs_file_system encrypted is set to true.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_efs_file_system encrypted should be set to true.",
		"snippet": block,
	}
}
