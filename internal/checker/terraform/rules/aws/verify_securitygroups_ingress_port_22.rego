# METADATA
# title: "Verify no security groups allow ingress from 0.0.0.0:0 to port 22"
# description: "This security check is aimed at verifying that no security groups in a network allow incoming traffic from the IP address range 0.0.0.0:0 to the port 22, which is the default port for SSH traffic."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# custom:
#   id: CB_TFAWS_044
#   severity: LOW
package lib.terraform.CB_TFAWS_044


supportedResource := [
        "aws_security_group", 
        "aws_security_group_rule", 
        "aws_vpc_security_group_ingress_rule"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
    childBlock := resource.Blocks[_]
    childBlock.Type == "ingress"
    childBlock.Attributes.to_port == "22"
    childBlock.Attributes.cidr_blocks[_] == "0.0.0.0/0"
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.type == "ingress"
    resource.Attributes.to_port == "22"
    resource.Attributes.cidr_blocks[_] == "0.0.0.0/0"
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.to_port == "22"
    resource.Attributes.cidr_blocks[_] == "0.0.0.0/0"
}


pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "No security groups rule allow ingress from 0.0.0.0:0 to port 22",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "security groups rule should not allow ingress from 0.0.0.0:0 to port 22.",
                "snippet": block }
} 