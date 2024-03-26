# METADATA
# title: "Verify the lambda environment for any hard-coded secrets"
# description: "Avoid storing hardcoded keys and secrets in infrastructure code or version-controlled configuration settings."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
# custom:
#   id: CB_TFAWS_040
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_040

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_lambda_function"
}

has_attribute(key, value) if {
	value in object.keys(key)
}

checkRegex(value) if {
	regex.match(`[A-Z0-9]{20}`, value)
}

checkRegex(value) if {
	regex.match(`[a-zA-Z0-9/+]{40}`, value)
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains block if {
	some block in input
	isvalid(block)
	some envblock in block.Blocks
	envblock.Type == "environment"
	some variables in envblock.Attributes.variables
	checkRegex(variables)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Hard-coded AWS access keys or secret keys not found.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Do not include hard-coded AWS access keys or secret keys.",
		"snippet": block,
	}
}












