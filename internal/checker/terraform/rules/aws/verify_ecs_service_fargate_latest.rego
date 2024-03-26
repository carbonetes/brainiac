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
	block.Attributes.launch_type == "FARGATE"
	block.Attributes.platform_version == "LATEST"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "ECS Fargate services run on the latest Fargate platform version.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "ECS Fargate services does not run on the latest Fargate platform version.",
		"snippet": block,
	}
}
