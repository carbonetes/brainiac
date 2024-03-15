# METADATA
# title: "Verify that CodeBuild Project encryption is not disabled"
# description: "This policy ensures that AWS CodeBuild, a fully managed build service, encrypts build artifacts by default using CMKs managed by AWS Key Management Service for Amazon S3. If desired, you can configure a customer-managed CMK instead."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codebuild-project.html
# custom:
#   id: CB_CFT_056
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_056

import future.keywords.in

resource := "AWS::CodeBuild::Project"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[encryption] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	encryption := resources.Properties.Artifacts
	encryption.Type == "S3"
	encryption.EncryptionDisabled == true
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
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
