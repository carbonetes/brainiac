# METADATA
# title: "Verify no open access to back-end through API"
# description: "This policy underscores that AWS API Gateway methods are initially public. To safeguard against data leaks and security breaches, all methods in the API Gateway should be protected by an Authorizer or an API key. It's recommended to configure a custom authorizer or an API key for each method to bolster security."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-apigateway-method.html
# custom:
#   id: CB_CFT_041
#   severity: LOW
package lib.cloudformation.CB_CFT_041
import future.keywords.in

resource := "AWS::ApiGateway::Method"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[properties] {
	is_valid
    some resources in input.Resources
    properties := resources.Properties
    properties.HttpMethod == "OPTIONS"
    properties.AuthorizationType == "NONE"
    properties.ApiKeyRequired == false
}

pass[resources] {
	resources := input.Resources
	is_valid
	count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "There is no open access to back-end resources through API",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "There is open access to back-end resources through API",
		"snippet": block,
	}
}
