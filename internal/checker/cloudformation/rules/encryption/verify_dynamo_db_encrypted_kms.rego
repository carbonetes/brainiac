# METADATA
# title: "Verify encryption for DynamoDB Tables using KMS CMK"
# description: "This policy encrypts Amazon DynamoDB to prevent unauthorized access or tampering, protecting against external threats like hackers or malware, as well as internal risks such as accidental or unauthorized access."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dynamodb-table.html
# custom:
#   id: CB_CFT_088
#   severity: LOW
package lib.cloudformation.CB_CFT_088

import future.keywords.in

resource := "AWS::DynamoDB::Table"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties.SSESpecification
	block.SSEEnabled == true
	block.KMSMasterKeyId
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "DynamoDB tables are encrypted using a customer-managed Key Management Service (KMS) key",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "DynamoDB tables are not encrypted using a customer-managed Key Management Service (KMS) key.",
		"snippet": block,
	}
}
