# METADATA
# title: "Verify ECS Cluster enables logging of ECS Exec"
# description: "Enabling logging of ECS Exec provides a log trail of all executed commands, including input and output, which can be valuable for auditing, compliance, and investigating any potential security or operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster#configuration
# custom:
#   id: CB_TFAWS_214
#   severity: LOW
package lib.terraform.CB_TFAWS_214

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ecs_cluster"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[blocks]{
    blocks := input[_]
	isvalid(blocks)
    blocks.Blocks[_].Type == "configuration"
    blocks.Blocks[_].Blocks[_].Type == "execute_command_configuration"
     blocks.Blocks[_].Blocks[_].Attributes.logging != "NONE"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "ECS Cluster enables logging of ECS Exec",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "ECS Cluster must enable logging of ECS Exec",
                "snippet": block }
} 