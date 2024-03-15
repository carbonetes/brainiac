# METADATA
# title: "Verify ECS cluster container insights are enabled"
# description: "This policy advocates using Container Insights for collecting and managing metrics and logs from containerized applications and microservices, simplifying monitoring, debugging, and alarm setup for all Amazon ECS resources. For existing clusters, utilize the AWS CLI; for new clusters, consider either the Amazon ECS console or the AWS CLI."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecs-cluster.html
# custom:
#   id: CB_CFT_047
#   severity: LOW
package lib.cloudformation.CB_CFT_047
import future.keywords.in

resource := "AWS::ECS::Cluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	cluster := properties.ClusterSettings
    some setting in cluster
    setting.Name == "containerInsights"
    setting.Value == "enabled"
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "ECR cluster insights are enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "ECR cluster insights should be enable",
		"snippet": block,
	}
}
