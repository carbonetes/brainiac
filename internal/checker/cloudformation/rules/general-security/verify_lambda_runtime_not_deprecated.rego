# METADATA
# title: "Verify runtime for Lambda is not deprecated"
# description: "This policy ensures Lambda functions use current runtimes, avoiding deprecated environments. Lambda, an AWS service, enables serverless code execution. Runtime here refers to the programming language environment. Using deprecated runtimes poses risks like lack of security updates and compatibility issues. Embracing outdated runtimes can escalate maintenance costs and technical debt."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html
# - https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-resource-function.html
# custom:
#   id: CB_CFT_120
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_120
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
	is_valid
	some resources in input.Resources
	properties := resources.Properties
	"Runtime" in object.keys(properties)
    runtime := properties.Runtime
    runtime_value := ["dotnetcore3.1", "nodejs12.x", "python3.6", "python2.7", "dotnet5.0", "dotnetcore2.1", "ruby2.5",
                "nodejs10.x", "nodejs8.10", "nodejs4.3", "nodejs6.10", "dotnetcore1.0", "dotnetcore2.0",
                "nodejs4.3-edge", "nodejs", "python3.7", "nodejs14.x", "ruby2.7", "provided", "go1.x", 
                "java8", "nodejs16.x", "dotnet7",]
    not runtime in runtime_value
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Lambda Runtime is not deprecated",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Lambda Runtime is deprecated",
		"snippet": block,
	}
}