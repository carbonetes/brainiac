# METADATA
# title: "Verify API Gateway caching is enabled"
# description: "Caching allows responses from your API to be stored temporarily and served to subsequent requests, reducing the need to process the same request repeatedly."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.9.0/docs/resources/api_gateway_stage
# custom:
#   id: CB_TFAWS_114
#   severity: LOW
package lib.terraform.CB_TFAWS_114

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_api_gateway_stage"
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
    resource.Attributes.cache_cluster_enabled == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_api_gateway_stage' cache_cluster_enabled is set.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_api_gateway_stage'cache_cluster_enabled should be set to true.",
                "snippet": block }
}
