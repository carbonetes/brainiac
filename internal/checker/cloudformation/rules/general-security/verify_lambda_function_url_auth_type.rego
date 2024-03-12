# METADATA
# title: "Verify Lambda function URLs AuthType is not None"
# description: "Defining the AWS AuthType for your Lambda function URLs is crucial as it dictates the authentication mechanism for user access, contributing to the security and protection of your functions against unauthorized entry."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-url.html
# custom:
#   id: CB_CFT_120
#   severity: LOW
package lib.cloudformation.CB_CFT_120

import future.keywords.in

resource := "AWS::Lambda::Url"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties
	block.AuthType == "NONE"
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Lambda function URLs AuthType is not None.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Lambda function URLs AuthType should not be None.",
		"snippet": block,
	}
}
