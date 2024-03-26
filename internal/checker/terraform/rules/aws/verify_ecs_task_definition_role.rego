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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ecs_task_definition"
}

has_attribute(key, value) if {
	value in object.keys(key)
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.execution_role_arn != resource.Attributes.task_role_arn
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	not has_attribute(resource.Attributes, "execution_role_arn")
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	not has_attribute(resource.Attributes, "task_role_arn")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Execution Role ARN and the Task Role ARN are different in ECS Task definitions.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Execution Role ARN and the Task Role ARN must not be the same in ECS Task definitions.",
		"snippet": block,
	}
}
