# METADATA
# title: "Verify Neptune DB cluster has automated backups enabled"
# description: "This policy ensures that an AWS Neptune DB cluster has automated backups enabled with an appropriate retention period. Failure to do so poses significant risks, including data loss, corruption, or compliance issues."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-neptune-dbcluster.html
# custom:
#   id: CB_CFT_119
#   severity: HIGH
package lib.cloudformation.CB_CFT_119
import future.keywords.in

resource := "AWS::Neptune::DBCluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
    backup_retention := properties.BackupRetentionPeriod
	"BackupRetentionPeriod" in object.keys(properties)
	backup_retention >= 7
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Neptune DB cluster has automated backups enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Neptune DB cluster automated backups is not enabled",
		"snippet": block,
	}
}