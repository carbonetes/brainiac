# METADATA
# title: "Make that ECS Task definitions for EFS volumes have Encryption in Transit enabled"
# description: "Examining ECS tasks, EFS specifications, and, if included, whether the transit is encrypted are all part of this check."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
# custom:
#   id: CB_TFAWS_072
#   severity: HIGH
package lib.terraform.CB_TFAWS_072

import future.keywords.in 



isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ecs_task_definition"
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
    volume := resource.Blocks[_]
    volume.Type == "volume"
    efs := volume.Blocks[_]
    efs.Type == "efs_volume_configuration"
    efs.Attributes.transit_encryption == "ENABLED"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "EFS volumes in ECS Task definitions are encrypted in transit.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "EFS volumes in ECS Task definitions should be encrypted in transit.",
                "snippet": block }
}
