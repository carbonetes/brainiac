# METADATA
# title: "Verify that CodeBuild Project encryption is not disabled"
# description: "Checks whether encryption is enabled for a CodeBuild Project."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codebuild-project.html
# custom:
#   id: CB_CFT_061
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_061

import future.keywords.in

resource := "AWS::CodeBuild::Project"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[encryption] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	encryption := resources.Properties.Artifacts
	encryption.Type == "S3"
	encryption.EncryptionDisabled == false
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "CodeBuild Project encryption is enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "CodeBuild Project encryption is disabled.",
		"snippet": block,
	}
}
