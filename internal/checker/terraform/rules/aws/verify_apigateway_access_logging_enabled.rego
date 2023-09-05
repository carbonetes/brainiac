# METADATA
# title: "Verify API Gateway has Access Logging enabled"
# description: "Enabling access logging for an API Gateway provides valuable insights into the requests and responses made to your API."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage
# custom:
#   id: CB_TFAWS_085
#   severity: LOW
package lib.terraform.CB_TFAWS_085

supportedResources := ["aws_api_gateway_stage", "aws_apigatewayv2_stage"]
isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "access_log_settings"
    has_attribute(block.Attributes, "destination_arn")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'API Gateway' 'access_log_settings' destination_arn is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'API Gateway ' 'access_log_settings' destination_arn should be set properly.",
                "snippet": block }
}
