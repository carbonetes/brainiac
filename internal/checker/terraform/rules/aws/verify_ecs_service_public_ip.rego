# METADATA
# title: "Verify ECS services do not have public IP addresses assigned to them automatically"
# description: "This policy is designed to ensure the security and controlled access of Amazon Web Services (AWS) Elastic Container Service (ECS) services by verifying that they do not have public IP addresses automatically assigned to them."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service#assign_public_ip
# custom:
#   id: CB_TFAWS_316
#   severity: HIGH
package lib.terraform.CB_TFAWS_316

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
	block.Blocks[_].Type == "network_configuration"
	block.Blocks[_].Attributes.assign_public_ip != true
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "ECS services don't have public IP addresses automatically assigned to them.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "ECS services have public IP addresses automatically assigned to them.",
		"snippet": block,
	}
}
