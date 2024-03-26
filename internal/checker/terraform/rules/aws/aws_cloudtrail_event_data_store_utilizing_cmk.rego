# METADATA
# title: "Require that the Cloud Trail Event Data Store utilizes a Customer Managed Key (CMK)"
# description: "The check validates whether the CloudTrail Event Data Store is utilizing a Customer Managed Key (CMK) to strengthen the encryption of critical data, bolstering security measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail_event_data_store
# custom:
#   id: CB_TFAWS_284
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_284

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudtrail_event_data_store"
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
	has_attribute(resource.Attributes, "kms_key_id")
	resource.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "A Customer Managed Key (CMK) is utilized by Cloud Trail Event Data Store.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "A Customer Managed Key (CMK) must be utilized by Cloud Trail Event Data Store.",
		"snippet": block,
	}
}
