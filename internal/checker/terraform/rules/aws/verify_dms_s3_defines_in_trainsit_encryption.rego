# METADATA
# title: "Verify DMS S3 defines in-transit encryption"
# description: "By enforcing in-transit encryption, data is protected against unauthorized access and potential eavesdropping during transit."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_s3_endpoint#ssl_mode
# custom:
#   id: CB_TFAWS_264
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_264

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_dms_s3_endpoint"
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
	resource.Attributes.ssl_mode != "none"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "DMS S3 defines in-transit encryption.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "DMS S3 must define in-transit encryption.",
		"snippet": block,
	}
}
