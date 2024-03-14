# METADATA
# title: "Verify all data on SNS Topic are encrypted"
# description: "Checks if encryption is specified for all data stored in AWS SNS Topic. AWS SNS Topic, part of Amazon Simple Notification Service (SNS), supports encryption, ensuring the secure transmission of sensitive data when messages are published to encrypted topics using customer master keys (CMK) powered by AWS KMS."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sns-topic.html
# custom:
#   id: CB_CFT_016
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_016

import future.keywords.in

resource := "AWS::SNS::Topic"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[encryption] {
	is_valid
	some resources in input.Resources
	encryption := resources.Properties
	not encryption.KmsMasterKeyId
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Encryption is specified for all data stored in the SNS Topic",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Encryption is not specified for all data stored in the SNS Topic",
        "snippet": block,
    }
}