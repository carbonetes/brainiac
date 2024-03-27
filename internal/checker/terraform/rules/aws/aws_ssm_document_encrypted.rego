# METADATA
# title: "Verify that all Session Manager data is transmitted securely"
# description: "When working with critical production data, it is strongly advised to use encryption at rest to prevent unwanted access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_document
# custom:
#   id: CB_TFAWS_087
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_087

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ssm_document"
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

fail contains block if {
	some block in input
	isvalid(block)
	contentstr := block.Attributes.content
	contentparsed := json.unmarshal(contentstr)
	not has_attribute(contentparsed.inputs, "kmsKeyId")
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Session Manager data is transmitted securely.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Session Manager data should be transmitted securely.",
		"snippet": block,
	}
}