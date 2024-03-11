# METADATA
# title: "Verify workspace user volume encryption"
# description: "Confirm the encryption status of Workspace user volumes to ensure data security."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-workspaces-workspace.html
# custom:
#   id: CB_CFT_100
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_100
import future.keywords.in

resource := "AWS::WorkSpaces::Workspace"

is_valid{
	some resources in input.Resources
    resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    properties := resources.Properties
    properties.UserVolumeEncryptionEnabled == true
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := {
		"message": "Workspace user volume encrypted",
		"snippet": properties,
	}
}

failed[result] {
	some properties in fail
	result := {
		"message": "Workspace user volume should be encrypted",
		"snippet": properties,
	}
}

