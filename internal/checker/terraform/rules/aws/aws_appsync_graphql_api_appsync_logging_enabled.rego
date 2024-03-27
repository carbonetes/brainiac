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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_appsync_graphql_api"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
    some log_config in resource.Blocks
    log_config.Type == "log_config"
    has_attribute(log_config.Attributes, "cloudwatch_logs_role_arn")
    log_config.Attributes.cloudwatch_logs_role_arn != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "AppSync logging is enabled.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "AppSync logging must be enabled.",
                "snippet": block }
} 