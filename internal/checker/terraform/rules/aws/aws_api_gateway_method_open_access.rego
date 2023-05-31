# METADATA
# title: "Check to make sure that there is no open API access to back-end resources"
# description: "By default, AWS API gateway methods are available to the public. Unprotected APIs can result in security lapses and data spills."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method
# custom:
#   id: CB_TFAWS_057
#   severity: LOW
package lib.terraform.CB_TFAWS_057

import future.keywords.in 

supportedResource := ["aws_api_gateway_method"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource] {
    resource := input[_]
    isvalid(resource)
    api_key_required := resource.Attributes.api_key_required
    authorization := resource.Attributes.authorization
    http_method := resource.Attributes.http_method
    authorization == "NONE" 
    http_method != "OPTIONS"
    api_key_required == false
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "aws_api_gateway_method has no open access to back-end resources through API.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_api_gateway_method should have no open access to back-end resources through API.",
                "snippet": block}
}


