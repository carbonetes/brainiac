# METADATA
# title: "Verify RDS Cluster authentication are enabled"
# description: "This policy leverages AWS Identity and Access Management (IAM) to authenticate users and applications accessing your RDS database, offering heightened security through IAM policies and multi-factor authentication."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbcluster.html
# custom:
#   id: CB_CFT_101
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_101
import future.keywords.in

resource := "AWS::RDS::DBCluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
 	"EnableIAMDatabaseAuthentication" in object.keys(properties)
    properties.EnableIAMDatabaseAuthentication != false
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "RDS cluster has IAM authentication enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RDS cluster have no IAM authentication enabled",
		"snippet": block,
	}
}