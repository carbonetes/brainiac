# METADATA
# title: "Enable encryption for SQS queue and uses custom master keys"
# description: "This control checks whether Amazon Simple Queue Service (SQS) queues are encrypted with AWS Key Management Service (AWS KMS) customer master keys (CMKs)."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue
# custom:
#   id: CB_TFAWS_014
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_014

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_sqs_queue"
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

pass contains resource if {
    some resource in input
	isvalid(resource)
    has_attribute(resource.Attributes, "kms_master_key_id")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_sqs_queue' 'kms_master_key_id' is set properly.",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_sqs_queue' 'kms_master_key_id' is not set properly.",
                "snippet": block }
} 