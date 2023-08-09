# METADATA
# title: "Verify that all NACL are connected to subnets"
# description: "Since this enables you to provide particular rules for regulating inbound and outbound traffic for those subnets, it is crucial to make it a priority that all NACLs are connected to subnets."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl.html
# custom:
#   id: CB_TFAWS_320
#   severity: LOW
package lib.terraform.CB_TFAWS_320


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_network_acl"
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

isAWSvpcExist{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_vpc"
}

isAWSSubnetExist{
    resource := input[_]
    resource.Type == "resource"
    resource.Labels[_] == "aws_subnet"
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    isAWSvpcExist
    isAWSSubnetExist
    has_attribute(resource.Attributes, "subnet_ids")
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    isAWSSubnetExist
    has_attribute(resource.Attributes, "subnet_ids")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "All NACL are connected to subnets.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "All NACL must be connected to subnets.",
                "snippet": block }
} 