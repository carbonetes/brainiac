# METADATA
# title: "Check that the ECS cluster's container insights are enabled"
# description: "Metrics and logs generated by containerized apps and microservices can be gathered, compiled, and summarized using Container Insights."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
# custom:
#   id: CB_TFAWS_060
#   severity: LOW
package lib.terraform.CB_TFAWS_060

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ecs_cluster"
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
	some setting in resource.Blocks
	setting.Type == "setting"
	setting.Attributes.name == "containerInsights"
	setting.Attributes.value == "enabled"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "aws_ecs_cluster container insights are enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_ecs_cluster container insights should be enabled.",
		"snippet": block,
	}
}