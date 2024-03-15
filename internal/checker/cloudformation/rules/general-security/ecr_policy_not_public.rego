# METADATA
# title: "Verify ECR policy is not exposed to the public"
# description: "AWS ECR simplifies Docker image management with managed repositories. Access control is governed by policies. Public repositories can expose confidential data, so limit public access to prevent data leakage."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecr-repository.html
# custom:
#   id: CB_CFT_022
#   severity: INFO
package lib.cloudformation.CB_CFT_022
import future.keywords.in

resource := "AWS::ECR::Repository"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	properties := resources.Properties
	some principal in properties.RepositoryPolicyText.Statement
	principal.Principal != "*"
	principal.Principal.AWS != "*"
	condition := properties.RepositoryPolicyText.Statement
	some conditions in condition
	conditions.Condition.Bool["aws:SecureTransport"] == "true"
	block := {principal}
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "ECR policy is not exposed to the public",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "ECR policy is exposed to the public",
		"snippet": block,
	}
}
