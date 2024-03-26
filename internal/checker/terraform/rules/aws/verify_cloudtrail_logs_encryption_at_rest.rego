# METADATA
# title: "Verify CloudTrail logs are encrypted with a KMS key"
# description: "CloudTrail logs contain sensitive information about your AWS account. You should encrypt them at rest to prevent unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail
# custom:
#   id: CB_TFAWS_032
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_032

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_cloudtrail"
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
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_cloudtrail' 'kms_key_id' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_cloudtrail' 'kms_key_id' is not set properly.",
		"snippet": block,
	}
}
