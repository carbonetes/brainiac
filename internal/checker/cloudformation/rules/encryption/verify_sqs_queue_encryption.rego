# METADATA
# title: "Verify all data on SQS Queue are encrypted"
# description: "Checks if encryption is specified for all data stored in AWS SQS Queue. Amazon Simple Queue Service (SQS) offers encryption capabilities for queues, ensuring the secure transmission of sensitive data."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-sqs-queue.html
# custom:
#   id: CB_CFT_017
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_017

import future.keywords.in

resource := "AWS::SQS::Queue"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

fail[sqs] {
    is_valid
    some resources in input.Resources
    sqs := resources.Properties
    not sqs.KmsMasterKeyId
}

pass[resources] {
    some resources in input.Resources
    is_valid
    count(fail) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Encryption is specified for all data stored in the SQS Queue",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Encryption is not specified for all data stored in the SQS Queue",
        "snippet": block,
    }
}