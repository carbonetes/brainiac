# METADATA
# title: "Verify workspace root volume encryption"
# description: "Confirm the encryption status of Workspace root volumes to ensure data security."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-workspaces-workspace.html
# custom:
#   id: CB_CFT_101
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_101
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
    properties.RootVolumeEncryptionEnabled == true
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := {
		"message": "Workspace root volume encrypted",
		"snippet": properties,
	}
}

failed[result] {
	some properties in fail
	result := {
		"message": "Workspace root volume should be encrypted",
		"snippet": properties,
	}
}

