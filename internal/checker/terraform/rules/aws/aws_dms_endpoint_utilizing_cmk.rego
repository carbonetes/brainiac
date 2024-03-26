# METADATA
# title: "Verify that the DMS endpoint utilizes a Customer Managed Key (CMK) for encryption"
# description: "This check verifies that the AWS Database Migration Service (DMS) endpoint utilizes a Customer Managed Key (CMK) for encryption, enhancing the security of sensitive data during migration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint
# custom:
#   id: CB_TFAWS_289
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_289

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_dms_endpoint"
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
	resource.Attributes.engine_name == "s3"
	resource.Blocks[_].Type == "s3_settings"
	some block in resource.Blocks
	has_attribute(block.Attributes, "server_side_encryption_kms_key_id")
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.engine_name != "s3"
	resource.Blocks[_].Type == "kms_key_arn"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "A Customer Managed Key (CMK) is utilized by the DMS endpoint for encryption.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "A Customer Managed Key (CMK) must be utilized by the DMS endpoint for encryption.",
		"snippet": block,
	}
}
