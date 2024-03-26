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

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ecs_service"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains block if {
	some block in input
	isvalid(block)
	some network in block.Blocks
	network.Type == "network_configuration"
	network.Attributes.assign_public_ip != true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "ECS services don't have public IP addresses automatically assigned to them.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "ECS services have public IP addresses automatically assigned to them.",
		"snippet": block,
	}
}
