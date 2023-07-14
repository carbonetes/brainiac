# METADATA
# title: "Verify API Gateway method setting caching is enabled"
# description: "Enabling caching for API Gateway method settings provides several benefits. It helps improve the performance and scalability of your APIs by reducing the load on backend systems."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings
# custom:
#   id: CB_TFAWS_224
#   severity: LOW
package lib.terraform.CB_TFAWS_224

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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "settings"
    resource.Blocks[_].Attributes.caching_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "API Gateway method setting caching is enable",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_api_gateway_method_settings' settings 'caching_enabled' should be set to latest",
                "snippet": block }
} 