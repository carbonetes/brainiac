# METADATA
# title: "Verify Encryption for SNS Topic"
# description: "Checks if encryption is specified for all data stored in AWS SNS Topic"
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