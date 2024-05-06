# METADATA
# title: "Verify App Flow flow uses CMK"
# description: "By using a CMK for encryption, you can have greater control over the encryption keys and their management, ensuring better security and compliance with data protection standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appflow_flow
# custom:
#   id: CB_TFAWS_257
#   severity: LOW
package lib.terraform.CB_TFAWS_257

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_appflow_flow"
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
	resource.Attributes.kms_arn != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_appflow_flow uses CMK.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_appflow_flow must use CMK.",
		"snippet": block,
	}
}
