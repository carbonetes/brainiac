# METADATA
# title: "Verify encryption for DocumentDB is at rest"
# description: "This policy ensures that Amazon DocumentDB clusters benefit from encryption, providing an added layer of data security against unauthorized access to the underlying storage. Encryption utilizes keys managed through the AWS Key Management Service (KMS), securing data at rest including backups, snapshots, and replicas within the cluster."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-docdb-dbcluster.html
# custom:
#   id: CB_CFT_054
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_054

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
