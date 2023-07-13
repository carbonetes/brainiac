# METADATA
# title: "Verify there are no resources named RDS Security Groups"
# description: "RDS Security Groups are only to be used when dealing with an RDS instance outside of a VPC, hence this resource shouldn't exist."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/figma/aws-4-49-0/latest/docs/resources/db_security_group
# custom:
#   id: CB_TFAWS_189
#   severity: LOW
package lib.terraform.CB_TFAWS_189

import future.keywords.in 



isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_db_security_group"
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
	result := { "message": "'RDS Security Groups' does not exist.",
                "snippet": block }
}
