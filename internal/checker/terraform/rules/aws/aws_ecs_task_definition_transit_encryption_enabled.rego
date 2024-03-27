# METADATA
# title: "Ensures ECS Task definitions for EFS volumes have Encryption in Transit enabled"
# description: "Examining ECS tasks, EFS specifications, and, if included, whether the transit is encrypted are all part of this check."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
# custom:
#   id: CB_TFAWS_072
#   severity: HIGH
package lib.terraform.CB_TFAWS_072

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_ecs_task_definition"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains resource if {
    some resource in input
	isvalid(resource)
    some volume in resource.Blocks
    volume.Type == "volume"
    some efs in volume.Blocks
    efs.Type == "efs_volume_configuration"
    efs.Attributes.transit_encryption != "ENABLED"
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := { "message": "EFS volumes in ECS Task definitions are encrypted in transit.",
                "snippet": block}
}

failed contains result if {
	some block in fail
	result := { "message": "EFS volumes in ECS Task definitions should be encrypted in transit.",
                "snippet": block }
}