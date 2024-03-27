# METADATA
# title: "Verify Redshift is using SSL"
# description: "Data security during transit is guaranteed through SSL connections."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_parameter_group
# custom:
#   id: CB_TFAWS_101
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_101

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_redshift_parameter_group"
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
	block.Type == "parameter"
	block.Attributes.name == "require_ssl"
	block.Attributes.value == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "aws_redshift_parameter_group SSL is enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_redshift_parameter_group SSL should be enabled.",
		"snippet": block,
	}
}
