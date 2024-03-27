# METADATA
# title: "Verify that Field-Level logs are activated in AppSync"
# description: "For AWS AppSync, a proper logging procedure is advised in order to spot unusual configuration activities. It can be utilized for tracking back unauthorized changes and track configuration changes made manually and automatically."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_graphql_api
# custom:
#   id: CB_TFAWS_185
#   severity: LOW
package lib.terraform.CB_TFAWS_185
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
    expected_value := ["ALL", "ERROR"]
    some log_config in resource.Blocks
    log_config.Type == "log_config"
    has_attribute(log_config.Attributes, "field_log_level")
    log_config.Attributes.field_log_level in expected_value
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "AppSync Field-Level logs are enabled.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "AppSync Field-Level logs must be enabled.",
                "snippet": block }
} 