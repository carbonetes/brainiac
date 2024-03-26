# METADATA
# title: "Verify that KMS encryption with a customer managed key (CMK) is employed for DynamoDB table replica encryption"
# description: "Ensure DynamoDB table replicas are encrypted using customer managed keys (CMKs) for enhanced data protection."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_replica.html
# custom:
#   id: CB_TFAWS_246
#   severity: HIGH
package lib.terraform.CB_TFAWS_246

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_dynamodb_table_replica"
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
	has_attribute(resource.Attributes, "kms_key_arn")
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
		"message": "DynamoDB table replica is utilizing CMK for encryption.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "DynamoDB table replica must utilize CMK for encryption.",
		"snippet": block,
	}
}
