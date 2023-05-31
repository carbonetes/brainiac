# METADATA
# title: "See to it that EFS is safely encrypted"
# description: "To prevent unwanted access to data and information, the Amazon EFS must be encrypted."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system
# custom:
#   id: CB_TFAWS_028
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_028

import future.keywords.in 

supportedResource := ["aws_efs_file_system"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "aws_efs_file_system encrypted is set to true.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_efs_file_system encrypted should be set to true.",
                "snippet": block }
}
