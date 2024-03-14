# METADATA
# title: "Verify encryption settings for the Lambda environment variable"
# description: "This policy allows you to adjust your function's behavior using environment variables, stored in version-specific configuration. The Lambda runtime provides access to these variables and sets additional ones containing function and invocation request details. It's important to note that environment variables are not evaluated before function invocation; they are treated as literal strings. Therefore, variable evaluation should be performed within your function code."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html
# custom:
#   id: CB_CFT_108
#   severity: LOW
package lib.cloudformation.CB_CFT_108
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

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
    "KmsKeyArn" in object.keys(properties)
    properties.KmsKeyArn != ""
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
    env := properties.Environment
    env != ""
    variable := env.Variables
    "Variables" in object.keys(variable)
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Encryption settings for Lambda environment variable passed",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Encryption settings for Lambda environment variable failed",
		"snippet": block,
	}
}