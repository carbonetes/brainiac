# METADATA
# title: "Verify DMS S3 uses Customer Managed Key (CMK)"
# description: "By using a CMK, you can have greater control over the encryption keys and enhance the security of your data during migration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_s3_endpoint#kms_key_arn
# custom:
#   id: CB_TFAWS_263
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_263

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
	resource.Attributes.kms_key_arn != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "DMS S3 uses Customer Managed Key (CMK).",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "DMS S3 must use Customer Managed Key (CMK).",
		"snippet": block,
	}
}
