# METADATA
# title: "Verify RDS DB authentication are enabled"
# description: "This policy utilizes AWS Identity and Access Management (IAM) to authenticate users and applications connecting to your RDS database, enhancing security by enabling IAM policies and multi-factor authentication for access control."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbinstance.html
# custom:
#   id: CB_CFT_100
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_100
import future.keywords.in

resource := "AWS::RDS::DBInstance"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
    "EnableIAMDatabaseAuthentication" in object.keys(properties)
    properties.EnableIAMDatabaseAuthentication != false
    engine_values := ["mysql", "postgres"]
    properties.Engine in engine_values
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "RDS database have IAM authentication enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RDS database have no IAM authentication enabled",
		"snippet": block,
	}
}