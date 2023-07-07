# METADATA
# title: "Verify that logging is enabled in AppSync"
# description: "To track configuration changes made manually and automatically as well as to identify unauthorized modifications, it is advised to have an effective logging process for AWS AppSync."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_graphql_api
# custom:
#   id: CB_TFAWS_184
#   severity: LOW
package lib.terraform.CB_TFAWS_184

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_appsync_graphql_api"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "log_config"
    has_attribute(resource.Blocks[_].Attributes, "cloudwatch_logs_role_arn")
    resource.Blocks[_].Attributes.cloudwatch_logs_role_arn != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AppSync logging is enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "AppSync logging must be enabled.",
                "snippet": block }
} 