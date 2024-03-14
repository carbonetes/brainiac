# METADATA
# title: "Verify encryption for Workspace user volumes"
# description: "This policy advocates encrypting Workspace user volumes to restrict unauthorized access or tampering, thereby guarding against both external threats like hackers or malware and internal risks such as accidental or unauthorized access."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-workspaces-workspace.html
# custom:
#   id: CB_CFT_095
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_095
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

