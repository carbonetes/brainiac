# METADATA
# title: "Verify all data on SNS Topic are encrypted"
# description: "This policy ensures that in Amazon SNS, messages published to encrypted topics can be encrypted using customer master keys (CMK) provided by AWS KMS. In regulated markets like healthcare (HIPAA), finance (PCI DSS), or government (FedRAMP), encrypting sensitive data messages transmitted through this service is imperative to maintain data security at rest."
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