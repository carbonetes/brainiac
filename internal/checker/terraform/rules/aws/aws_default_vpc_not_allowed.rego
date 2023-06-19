# METADATA
# title: "Verify that no default VPC is going to be provisioned"
# description: "The constraints of default VPCs may make them incompatible for all use cases."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc.html
# custom:
#   id: CB_TFAWS_133
#   severity: LOW
package lib.terraform.CB_TFAWS_133

import future.keywords.in 



isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_default_vpc"
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
    resource.Labels[_] == "aws_default_vpc"
}

pass[resource] {
    resource := input[_]
    not fail[resource]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_default_vpc' is not provisioned.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_default_vpc' should not be provisioned.",
                "snippet": block }
}
