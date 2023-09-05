# METADATA
# title: "Verify ECS Fargate services run on the latest Fargate platform version"
# description: "This policy is designed to ensure the optimal performance, security, and feature availability of Amazon Web Services (AWS) Elastic Container Service (ECS) Fargate services by verifying that they are running on the latest Fargate platform version."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
# custom:
#   id: CB_TFAWS_315
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_315

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_ecs_service"
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.launch_type == "FARGATE"
	block.Attributes.platform_version == "LATEST"
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "ECS Fargate services run on the latest Fargate platform version.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "ECS Fargate services does not run on the latest Fargate platform version.",
		"snippet": block,
	}
}
