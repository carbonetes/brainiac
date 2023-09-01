# METADATA
# title: "Be certain that every VPC's default security group prohibits all traffic"
# description: "We advise users to restrict all incoming and outgoing traffic with the default security group. Every region's default VPC's default security group should be changed to adhere to this suggestion."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group.html
# custom:
#   id: CB_TFAWS_342
#   severity: LOW
package lib.terraform.CB_TFAWS_342

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_default_security_group"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

getTheLabelAwsVpc[label]{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_vpc"
    label := concat(".", resource.Labels)
}

isValidResourceAttached{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_default_security_group"
    label := getTheLabelAwsVpc[_]
    contains(resource.Attributes.vpc_id, label)
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
    resource.Blocks[_].Type == "ingress"
    resource.Blocks[_].Attributes.to_port
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
    resource.Blocks[_].Type == "ingress"
    resource.Blocks[_].Attributes.from_port
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
    resource.Blocks[_].Type == "ingress"
    resource.Blocks[_].Attributes.self
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
    resource.Blocks[_].Type == "ingress"
    resource.Blocks[_].Attributes.protocol
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
    resource.Blocks[_].Type == "egress"
    resource.Blocks[_].Attributes.from_port
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
    resource.Blocks[_].Type == "egress"
    resource.Blocks[_].Attributes.to_port
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
    resource.Blocks[_].Type == "egress"
    resource.Blocks[_].Attributes.cidr_blocks
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    isValidResourceAttached
    resource.Blocks[_].Type == "egress"
    resource.Blocks[_].Attributes.protocol
}

fail[resource]{
    resource := input[_]
    isvalid(resource)
    not isValidResourceAttached
}

pass[block] {
    block := input[_]
	isvalid(block)
    isValidResourceAttached
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Every VPC's default security group prohibits all traffic.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Every VPC's default security group must prohibit all traffic.",
                "snippet": block }
} 