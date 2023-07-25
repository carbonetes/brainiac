# METADATA
# title: "Make certain that Data Trace is disabled in API Gateway Method Settings"
# description: "AWS security group enables unrestricted internet access by enabling all ingress traffic on all ports. Check to see if ports are defined appropriately."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_method_settings
# custom:
#   id: CB_TFAWS_251
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_251

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_api_gateway_method_settings"
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

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "settings"
    resource.Blocks[_].Attributes.data_trace_enabled == true
}

passed[result] {
	block := pass[_]
	result := { "message": "CData Trace is disabled in API Gateway Method Settings.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Data Trace must be disabled in API Gateway Method Settings.",
                "snippet": block }
} 