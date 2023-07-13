# METADATA
# title: "AMI launch permissions should be restricted"
# description: "It is advised against enabling the launch of AMIs across many accounts, and if it is, make sure it is used appropriately."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami_launch_permission.html
# custom:
#   id: CB_TFAWS_204
#   severity: LOW
package lib.terraform.CB_TFAWS_204

import future.keywords.in 



isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ami_launch_permission"
}

resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
}


passed := []

failed[result] {
    block := fail[_]
	result := { "message": "AMI launch permissions are not allowed.",
                "snippet": block }
}
