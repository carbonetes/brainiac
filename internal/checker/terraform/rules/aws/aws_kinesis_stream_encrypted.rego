# METADATA
# title: "AWS Kinesis streams must be encrypted"
# description: "We advise you to make sure server-side encryption (SSE) is used to encrypt Kinesis streams."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_stream
# custom:
#   id: CB_TFAWS_027
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_027

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_kinesis_stream"
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
	valid_encryption_types = ["KMS", "NONE"]
	some resource in input
	isvalid(resource)
	resource.Attributes.encryption_type in valid_encryption_types
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "aws_kinesis_stream is encrypted.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_kinesis_stream should be encrypted.",
		"snippet": block,
	}
}
