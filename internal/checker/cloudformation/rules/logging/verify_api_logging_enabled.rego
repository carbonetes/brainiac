# METADATA
# title: "Verify API Gateway V2 has access logging enabled"
# description: "This policy enables custom access logging in API Gateway, delivering logs to CloudWatch Logs for analysis with CloudWatch Logs Insights. Additionally, it facilitates tracking requests to specific custom domain names, providing insights into request patterns when multiple domains are associated with a single API."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/sam-resource-httpapi.html
# custom:
#   id: CB_CFT_75
#   severity: LOW
package lib.cloudformation.CB_CFT_75    
import future.keywords.in

resource := "AWS::Serverless::HttpApi"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	accesslog := properties.AccessLogSettings
	accesslog.DestinationArn != ""
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "API Gateway V2 has Access Logging enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "API Gateway V2 has Access Logging not enabled",
		"snippet": block,
	}
}
