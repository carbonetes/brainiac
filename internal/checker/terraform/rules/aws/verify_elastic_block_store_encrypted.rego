# METADATA
# title: "Make sure that all data stored in the Elastic Block Store of the instance or the Launch Configuration is encrypted in a secure manner."
# description: "It helps to prevent unauthorized access, data leakage, and potential data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration#root_block_device
# custom:
#   id: CB_TFAWS_007
#   severity: HIGH
package lib.terraform.CB_TFAWS_007

import future.keywords.in 

supportedResource := ["aws_instance", "aws_launch_configuration"]

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
    block := resource.Blocks[_]
    block.Type == "root_block_device"
    block.Attributes.encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'root_block_device' should is set properly.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'root_block_device' should be set to true.",
                "snippet": block }
}