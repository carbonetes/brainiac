# METADATA
# title: "Verify Redshift is using SSL"
# description: "Data security during transit is guaranteed through SSL connections."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_parameter_group
# custom:
#   id: CB_TFAWS_101
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_101

import future.keywords.in 

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_redshift_parameter_group"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 


pass[resource] {
    resource := input[_]
    isvalid(resource)
    block := resource.Blocks[_]
    block.Type == "parameter"
    block.Attributes.name == "require_ssl"
    block.Attributes.value == true
}


fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "aws_redshift_parameter_group SSL is enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "aws_redshift_parameter_group SSL should be enabled.",
                "snippet": block}
}
