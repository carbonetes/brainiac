# METADATA
# title: "Enable and encrypt Session Manager logs"
# description: "Encrypting your ession Manager logs helps protect your data from unauthorized access or tampering."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_document
# custom:
#   id: CB_TFAWS_118
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_118

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

pass contains block if {
	some block in input
	isvalid(block)
	contentstr := block.Attributes.content
	contentparsed := json.unmarshal(contentstr)
	has_attribute(contentparsed.inputs, "s3BucketName")
	contentparsed.inputs.s3EncryptionEnabled == true
}

pass contains block if {
	some block in input
	isvalid(block)
	contentstr := block.Attributes.content
	contentparsed := json.unmarshal(contentstr)
	has_attribute(contentparsed.inputs, "cloudWatchLogGroupName")
	contentparsed.inputs.cloudWatchEncryptionEnabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Session Manager logs are active and encrypted.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Session Manager logs should be active and encrypted.",
		"snippet": block,
	}
}