# METADATA
# title: "Verify AWS Lambda Function VPC Configuration"
# description: "Lambda securely runs functions within its isolated VPC, separate from the account's default VPC, and to grant internet access from a private subnet, you need to route outbound traffic to a NAT gateway in a public subnet."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html
# custom:
#   id: CB_CFT_091
#   severity: LOW
package lib.cloudformation.CB_CFT_091

import future.keywords.in

is_valid {
	supported_resources := ["AWS::Lambda::Function", "AWS::Serverless::Function"]
	some resources in input.Resources
	resources.Type in supported_resources
}

resource[type] {
	some resource in input.Resources
	is_valid
	count(fail) > 0
	type := resource.Type
}

resource[type] {
	some resource in input.Resources
	is_valid
	count(pass) > 0
	type := resource.Type
}

fail[block] {
	is_valid
	some resources in input.Resources
	block := resources.Properties
	not block.VpcConfig
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "VPC is configured inside the AWS Lambda function.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "VPC is not configured inside the AWS Lambda function.",
		"snippet": block,
	}
}