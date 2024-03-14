# METADATA
# title: "Verify KMS encryption for Cloudwatch log group"
# description: "This policy requires encryption settings for log group data in CloudWatch Logs. While developers can use AWS Key Management Service for encryption, there are limitations: revoking access to CloudWatch Logs or deleting an associated KMS key will prevent retrieval of encrypted data. Additionally, associating a KMS key with a log group isn't supported through the CloudWatch console."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-loggroup.html
# custom:
#   id: CB_CFT_098
#   severity: LOW
package lib.cloudformation.CB_CFT_098
import future.keywords.in

resource := "AWS::Logs::LogGroup"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
	is_valid
	some resources in input.Resources
	properties := resources.Properties
    properties.KmsKeyId != ""
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := {
		"message": "KMS encryption enabled in Cloudwatch log group",
		"snippet": properties,
	}
}

failed[result] {
	some properties in fail
	result := {
		"message": "KMS encryption should be enable in Cloudwatch log group",
		"snippet": properties,
	}
}