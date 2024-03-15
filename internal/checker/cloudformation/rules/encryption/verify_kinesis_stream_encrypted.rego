# METADATA
# title: "Verify Kinesis Stream is encrypted"
# description: "This policy ensures that Amazon Kinesis Data Firehose routes messages to destinations like S3, Redshift, and Elasticsearch, while also providing data transformation capabilities. It mandates server-side encryption using AWS KMS keys for sensitive data streams, enhancing security during transmission and storage."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-kinesis-stream.html
# custom:
#   id: CB_CFT_029
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_029
import future.keywords.in

resource := "AWS::Kinesis::Stream"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
	is_valid
	some resources in input.Resources
	properties := resources.Properties.StreamEncryption
	properties.EncryptionType == "KMS"
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Kinesis Stream is encrypted",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Kinesis Stream should be encrypted",
		"snippet": block,
	}
}
