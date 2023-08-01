# METADATA
# title: "Verify that the Execution Role ARN and the Task Role ARN are different in ECS Task definitions."
# description: "By using different Execution Role ARN and Task Role ARN in ECS Task Definitions, you can enforce the principle of least privilege, ensuring that each component of your application has only the necessary permissions it requires, thus enhancing security and minimizing potential attack surfaces."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
# custom:
#   id: CB_TFAWS_281
#   severity: LOW
package lib.terraform.CB_TFAWS_281

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_ecs_task_definition"
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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.execution_role_arn != resource.Attributes.task_role_arn
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    not has_attribute(resource.Attributes, "execution_role_arn")
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    not has_attribute(resource.Attributes, "task_role_arn")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Execution Role ARN and the Task Role ARN are different in ECS Task definitions.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Execution Role ARN and the Task Role ARN must not be the same in ECS Task definitions.",
                "snippet": block }
} 