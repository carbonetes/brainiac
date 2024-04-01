# METADATA
# title: "Verify DynamoDB Tables are encrypted using a KMS Customer Managed CMK"
# description: "By utilizing a customer-managed CMK for encryption, you can ensure that the encryption keys used to protect your DynamoDB data are managed and controlled by you."
# scope: package
# related_resources:
# - https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws/latest
# custom:
#   id: CB_TFAWS_111
#   severity: LOW
package lib.terraform.CB_TFAWS_111

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_dynamodb_table"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

has_attribute(key, value) if {
	value in object.keys(key)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "server_side_encryption"
	block.Attributes.enabled == true
	has_attribute(block.Attributes, "kms_key_arn")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_dynamodb_table' is encrypted using KMS Customer Managed CMK",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_dynamodb_table'is not encrypted using KMS Customer Managed CMK",
		"snippet": block,
	}
}