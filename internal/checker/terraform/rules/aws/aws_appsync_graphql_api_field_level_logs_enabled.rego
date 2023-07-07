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
    fieldLogLevelValues := ["ALL", "ERROR"]
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "log_config"
    has_attribute(resource.Blocks[_].Attributes, "field_log_level")
    resource.Blocks[_].Attributes.field_log_level == fieldLogLevelValues[_]
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AppSync Field-Level logs are enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "AppSync Field-Level logs must be enabled.",
                "snippet": block }
} 