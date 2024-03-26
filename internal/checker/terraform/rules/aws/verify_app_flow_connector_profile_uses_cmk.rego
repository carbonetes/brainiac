# METADATA
# title: "Verify App Flow connector profile uses CMK"
# description: "When AppFlow connector profiles use CMK for encryption, the sensitive data exchanged between connectors is safeguarded and protected from unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appflow_connector_profile
# custom:
#   id: CB_TFAWS_258
#   severity: LOW
package lib.terraform.CB_TFAWS_258

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_appflow_connector_profile"
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
		"message": "'aws_appflow_connector_profile uses CMK.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_appflow_connector_profile must use CMK.",
		"snippet": block,
	}
}
