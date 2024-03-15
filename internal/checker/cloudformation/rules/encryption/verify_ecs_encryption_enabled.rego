# METADATA
# title: "Verify ECS encryption on volumes are enabled"
# description: "This policy evaluates ECS tasks by inspecting their definitions for EFS usage. It verifies whether encryption in transit is enabled for attached EFS volumes."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-taskdefinition.html
# custom:
#   id: CB_CFT_072
#   severity: HIGH
package lib.cloudformation.CB_CFT_072
import future.keywords.in

resource := "AWS::ECS::TaskDefinition"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	some volume in properties.Volumes
    transit := volume.EFSVolumeConfiguration
    transit.TransitEncryption == "ENABLED"
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Encryption for EFS volumes in ECS Task definitions are enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Encryption for EFS volumes in ECS Task definitions is not enabled",
		"snippet": block,
	}
}
