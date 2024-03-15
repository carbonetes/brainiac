# METADATA
# title: "Verify Immutability for ECR Image Tags."
# description: "This policy introduces immutable tags in Amazon ECR, preventing tag overwrites. It allows users to rely on descriptive tags to uniquely identify images, aiding in version tracking and correlation with builds."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecr-repository.html
# custom:
#   id: CB_CFT_034
#   severity: LOW
package lib.cloudformation.CB_CFT_034
import future.keywords.in

resource := "AWS::ECR::Repository"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    properties := resources.Properties
    block := properties.ImageTagMutability
    block == "IMMUTABLE"
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "ECR Image Tags are Immutable",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "ECR Image Tags are not Immutable",
		"snippet": block,
	}
}
