# METADATA
# title: "Verify public API gateway are protected by WAF"
# description: "WAF serves as a security layer that safeguards web applications from various types of online threats, including malicious attacks and unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_deployment.html
# custom:
#   id: CB_TFAWS_331
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_331


isGatewayStage(block){
	block.Type == "resource"
    block.Labels[_] == "aws_api_gateway_stage"
}

isGatewayRes(block){
	block.Type == "resource"
    block.Labels[_] == "aws_api_gateway_rest_api"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getGatewayRestLabel[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_api_gateway_rest_api"
    label := concat(".", resource.Labels)
}

restPrivate{
    resource := input[_]
	isGatewayRes(resource)
    block := resource.Blocks[_]
    block.Type == "endpoint_configuration"
    block.Attributes.types[_] == "PRIVATE"
}

fail[resource]{
    resource := input[_]
	isGatewayStage(resource)
    contains(resource.Attributes.rest_api_id, getGatewayRestLabel[_])
    not restPrivate

}

pass[block] {
    block := input[_]
	isGatewayStage(block)
   	not fail[block]
}


passed[result] {
	block := pass[_]
	result := { "message": "Public API gateway are protected by WAF.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Public API gateway should be protected by WAF.",
                "snippet": block }
} 