# METADATA
# title: "Enable encryption for SNS topics and uses custom master keys"
# description: "This control checks whether SNS topics are encrypted with a customer-managed CMK."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic
# custom:
#   id: CB_TFAWS_011
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_011

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_sns_topic"
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
	result := { "message": "'aws_sns_topic' 'kms_master_key_id' is set properly.",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_sns_topic' 'kms_master_key_id' is not set properly.",
                "snippet": block }
} 