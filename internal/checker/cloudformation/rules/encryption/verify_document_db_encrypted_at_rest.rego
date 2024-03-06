# METADATA
# title: "Verify DocumentDB is encrypted at rest (default is unencrypted)"
# description: "Checks whether DocumentDB is encrypted at rest."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-docdb-dbcluster.html
# custom:
#   id: CB_CFT_059
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_059

import future.keywords.in

resource := "AWS::DocDB::DBCluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties
	block.StorageEncrypted == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "DocumentDB is encrypted at rest.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "DocumentDB is not encrypted at rest (default is unencrypted).",
		"snippet": block,
	}
}
