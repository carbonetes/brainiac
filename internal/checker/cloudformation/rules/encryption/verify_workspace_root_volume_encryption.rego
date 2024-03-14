# METADATA
# title: "Verify encryption for Workspace root volumes"
# description: "This policy advises encrypting Workspace root volumes to restrict unauthorized access or tampering, safeguarding against external threats like hackers or malware, as well as internal risks such as accidental or unauthorized access."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-workspaces-workspace.html
# custom:
#   id: CB_CFT_096
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_096
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

