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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_ecs_cluster"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
}  

pass contains resource if {
    some resource in input
	isvalid(resource)
    some type in resource.Blocks
    type.Type == "configuration"
    some block in type.Blocks
    block.Type == "execute_command_configuration"
    block.Attributes.logging != "NONE"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "ECS Cluster enables logging of ECS Exec",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "ECS Cluster must enable logging of ECS Exec",
                "snippet": block }
} 