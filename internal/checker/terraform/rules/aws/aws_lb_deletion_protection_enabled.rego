# METADATA
# title: "Verify that deletion protection is activated in the load balancer"
# description: "This policy recognizes Elastic Load Balancers version 2 (ELBv2) that have the deletion protection option turned off. By enabling delete protection for these ELBs, irrevocable data loss brought on by mistaken or malicious actions is avoided."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.61.0/docs/data-sources/lb
# custom:
#   id: CB_TFAWS_129
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_129

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
    has_attribute(resource.Attributes, "enable_deletion_protection")
    resource.Attributes.enable_deletion_protection == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_alb', 'aws_lb' deletion protection is active.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_alb', 'aws_lb' deletion protection should be active.",
                "snippet": block }
}
