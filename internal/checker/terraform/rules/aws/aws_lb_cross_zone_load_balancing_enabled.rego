# METADATA
# title: "Make certain cross-zone load balancing is enabled in the load balancer (network/gateway)"
# description: "With the use of a feature called cross-zone load balancing, all activated availability zones' healthy targets receive an equal share of the incoming traffic. This can guarantee that your application can manage more traffic, lower the possibility of any availability zone getting overwhelmed, and may affect the performance of your load balancer."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.61.0/docs/data-sources/lb
# custom:
#   id: CB_TFAWS_132
#   severity: LOW
package lib.terraform.CB_TFAWS_132

import future.keywords.in 

supportedResource := ["aws_alb", "aws_lb"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

has_attribute(key, value){
    _ = key[value]
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
    has_attribute(resource.Attributes, "enable_cross_zone_load_balancing")
    resource.Attributes.enable_cross_zone_load_balancing == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_alb', 'aws_lb' cross-zone load balancing is active.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_alb', 'aws_lb' cross-zone load balancing is active.",
                "snippet": block }
}
