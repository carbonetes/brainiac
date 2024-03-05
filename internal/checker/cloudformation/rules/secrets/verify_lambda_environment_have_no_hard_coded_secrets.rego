# METADATA
# title: "Verify Lambda environment have no hard coded secrets."
# description: "This policy checks AWS Lambda functions to ensure that no hard-coded secrets are present in their environment variables."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html
# - https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-resource-function.html
# custom:
#   ID: CB_CFT_35
#   Severity: High
package lib.cloudformation.CB_CFT_35

import future.keywords.in

resource := ["AWS::Lambda::Function", "AWS::Serverless::Function"]

is_valid {
	some resources in input.Resources
	resources.Type in resource
}

pass[resources] {
	is_valid
	resources := input.Resources
	count(fail) == 0
}

fail[block] {
	is_valid
	some resources in input.Resources
	some environment_variables in resources.Properties.Environment.Variables
	regex_pattern = `^arn:aws:secretsmanager:[a-z0-9-]+:[0-9]+:secret:[a-zA-Z0-9-_]+$`
	regex.match(regex_pattern, environment_variables)
	block := resources.Properties.Environment.Variables
}

passed[result] {
	some resources in pass
	result := {
		"message": "No hard coded secrets in lambda environment.",
		"snippet": resources,
	}
}

failed[result] {
	some resources in fail
	result := {
		"message": "Hard coded secrets found in lambda environment.",
		"snippet": resources,
	}
}
