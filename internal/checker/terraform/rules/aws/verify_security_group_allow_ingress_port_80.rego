# METADATA
# title: "Verify no security groups allow ingress from 0.0.0.0:0 to port 80"
# description: "By restricting inbound access to port 80, which is commonly used for HTTP web traffic, only to specific trusted sources, it reduces the risk of unauthorized access or potential security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.56.0/docs/resources/security_group#ingress
# custom:
#   id: CB_TFAWS_252
#   severity: HIGH
package lib.terraform.CB_TFAWS_252

supportedResources := ["aws_security_group", "aws_security_group_rule", "aws_vpc_security_group_ingress_rule"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

has_attribute(key, value) {
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

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource] {
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "ingress"
    resource.Blocks[_].Attributes.cidr_blocks[_] == "0.0.0.0/0"
    to_number(resource.Blocks[_].Attributes.from_port) == 80
}

fail[resource] {
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "ingress"
    resource.Blocks[_].Attributes.cidr_blocks[_] == "0.0.0.0/0"
    to_number(resource.Blocks[_].Attributes.from_port) == 80
}


passed[result] {
	block := pass[_]
	result := { "message": "No security groups allow ingress from 0.0.0.0:0 to port 80",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_security_group must not allow ingress from 0.0.0.0:0 to port 80.",
                "snippet": block }
}
