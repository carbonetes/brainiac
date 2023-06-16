# METADATA
# title: "Verify VPC subnets do not assign public IP by default"
# description: "By ensuring that subnets do not automatically assign public IP addresses to instances, you can prevent accidental exposure of resources to the public internet and reduce the attack surface."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/2.43.0/docs/resources/subnet
# custom:
#   id: CB_TFAWS_128
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_128


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_subnet"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource] {
    resource := input[_]
    isvalid(resource)
    resource.Attributes.map_public_ip_on_launch == true

}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "VPC subnets is not assign public IP by default",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "VPC subnets should not assign public IP by default",
                "snippet": block}
}
