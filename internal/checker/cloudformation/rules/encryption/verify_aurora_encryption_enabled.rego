# METADATA
# title: "Verify data stored in Aurora are securely encrypted"
# description: "This policy evaluates the AWS resource aws-rds-cluster to verify the configuration of encryption. It assesses the property storage-encrypted."
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbcluster.html
# custom:
#   id: CB_CFT_071
#   severity: HIGH
package lib.cloudformation.CB_CFT_071
import future.keywords.in

resource := "AWS::RDS::DBCluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	properties.StorageEncrypted == true
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Data stored in Aurora is securely encrypted",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Data stored in Aurora is not encrypted",
		"snippet": block,
	}
}
