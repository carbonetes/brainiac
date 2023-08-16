# METADATA
# title: "Verify AWS NAT Gateways are utilized for the default route"
# description: "This practice ensures that outbound traffic from private resources flows through a secure and managed NAT Gateway, providing reliable connectivity while preventing direct exposure to the public internet."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route.html
# custom:
#   id: CB_TFAWS_337
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_337

validResources := ["aws_route", "aws_route_table"]
isvalid(block){
	block.Type == "resource"
    block.Labels[_] == validResources[_]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[block] {
	block := input[_]
	isvalid(block)
    innerBlock := block.Blocks[_]
    innerBlock.Type == "route"
	innerBlock.Attributes.instance_id != ""
    innerBlock.Attributes.cidr_block == "0.0.0.0/0"
}

fail[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.instance_id != ""
	block.Attributes.destination_cidr_block == "0.0.0.0/0"
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AWS NAT Gateways are utilized for the default route",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "AWS NAT Gateways should be utilized for the default route.",
                "snippet": block }
} 