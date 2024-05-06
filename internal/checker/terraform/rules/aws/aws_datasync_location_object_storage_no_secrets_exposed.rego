# METADATA
# title: "Verify that DataSync Location Object Storage does not reveal sensitive information"
# description: "This check examines the DataSync Location Object Storage configuration to prevent any exposure of sensitive information or secrets."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/datasync_location_object_storage
# custom:
#   id: CB_TFAWS_286
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_286

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_datasync_location_object_storage"
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
	not fail[block]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	has_attribute(resource.Attributes, "secret_key")
	resource.Attributes.secret_key != ""
}

passed contains result if {
	some block in pass
	result := {
		"message": "DataSync Location Object Storage does not reveal secrets.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "DataSync Location Object Storage must not reveal secrets.",
		"snippet": block,
	}
}
