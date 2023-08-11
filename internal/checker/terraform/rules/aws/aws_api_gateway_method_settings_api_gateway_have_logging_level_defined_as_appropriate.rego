# METADATA
# title: "Verify that the API Gateway stage has the appropriate logging level specified"
# description: "Setting the right logging level for your API Gateway stages is highly recommended because it enables you to record and examine specific details about the requests and replies processed by your API."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings
# custom:
#   id: CB_TFAWS_326
#   severity: LOW
package lib.terraform.CB_TFAWS_326

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_api_gateway_method_settings"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getApiGatewayStageLabel[label] {
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_api_gateway_stage"
    label := concat(".", resource.Labels)
}

isValidResourceAttached{
resource := input[_]
resource.Type == "resource"
resource.Labels[_] == "aws_api_gateway_method_settings"
gatewayStageLabel := getApiGatewayStageLabel[_]
startswith(resource.Attributes.stage_name, gatewayStageLabel)
}

pass[resource]{
resource := input[_]
isvalid(resource)
expectedValues := ["ERROR", "INFO"]
isValidResourceAttached
resource.Blocks[_].Type == "settings"
resource.Blocks[_].Attributes.logging_level == expectedValues[_]
resource.Blocks[_].Attributes.metrics_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "API Gateway stage has the appropriate logging level specified.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "API Gateway stage must have the appropriate logging level specified.",
                "snippet": block }
} 