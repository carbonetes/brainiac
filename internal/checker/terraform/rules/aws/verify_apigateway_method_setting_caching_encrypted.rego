# METADATA
# title: "Verify API Gateway method setting caching is set to encrypted"
# description: "Verifying that API Gateway method setting caching is set to encrypted enhances data security by ensuring that cached data remains confidential and protected from unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.49.0/docs/resources/api_gateway_method_settings#cache_data_encrypted
# custom:
#   id: CB_TFAWS_291
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_291

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_api_gateway_method_settings"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "settings"
    resource.Blocks[_].Attributes.cache_data_encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "API Gateway method setting caching is set to encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "API Gateway method setting caching must be encrypted",
                "snippet": block }
}
