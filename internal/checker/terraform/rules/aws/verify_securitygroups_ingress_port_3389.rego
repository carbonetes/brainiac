# METADATA
# title: "Verify no security groups allow ingress from 0.0.0.0:0 to port 3389"
# description: "Verifying that no security groups allow ingress from 0.0.0.0:0 to port 3389 provides a layer of protection against unauthorized access to sensitive resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# custom:
#   id: CB_TFAWS_046
#   severity: LOW
package lib.terraform.CB_TFAWS_046


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
    childBlock.Attributes.to_port == "3389"
    childBlock.Attributes.cidr_blocks[_] == "0.0.0.0/0"
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.type == "ingress"
    resource.Attributes.to_port == "3389"
    resource.Attributes.cidr_blocks[_] == "0.0.0.0/0"
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.to_port == "3389"
    resource.Attributes.cidr_blocks[_] == "0.0.0.0/0"
}


pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "No security groups rule allow ingress from 0.0.0.0:0 to port 3389",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "security groups rule should not allow ingress from 0.0.0.0:0 to port 3389.",
                "snippet": block }
} 