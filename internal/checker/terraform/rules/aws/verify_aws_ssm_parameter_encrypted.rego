# METADATA
# title: "Verify AWS SSM Parameter is Encrypted"
# description: "This safeguards sensitive data from unauthorized access or exposure, maintaining the confidentiality and integrity of your critical information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter.html
# custom:
#   id: CB_TFAWS_336
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_336

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ssm_parameter"
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
	resource.Attributes.type == "SecureString"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS SSM Parameter is Encrypted.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS SSM Parameter Attributes 'type' should be set to 'SecureString'.",
		"snippet": block,
	}
}
