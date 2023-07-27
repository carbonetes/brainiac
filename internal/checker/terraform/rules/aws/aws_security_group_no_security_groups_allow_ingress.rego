# METADATA
# title: "Verify that no security groups permit incoming connections from 0.0.0.0:0 to port -1"
# description: "AWS security group enables unrestricted internet access by enabling all ingress traffic on all ports. Check to see if ports are defined appropriately."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
# custom:
#   id: CB_TFAWS_253
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_253

supportedResource := ["aws_security_group", "aws_security_group_rule", "aws_vpc_security_group_ingress_rule"]

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

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "ingress"
    fromPort := to_number(resource.Blocks[_].Attributes.from_port)
    toPort := to_number(resource.Blocks[_].Attributes.to_port)
    fromPort == -1
    toPort == -1
}

passed[result] {
	block := pass[_]
	result := { "message": "Security groups do not permit incoming connections from 0.0.0.0:0 to port -1.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Security groups must not permit incoming connections from 0.0.0.0:0 to port -1.",
                "snippet": block }
} 