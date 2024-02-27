# METADATA
# title: "Verify all ElastiCache Replication Group data is encrypted in transit with authentication tokens."
# description: "Authentication becomes feasible solely during the creation of clusters with in-transit encryption activated. With Redis authentication enabled, users are obliged to pass through an extra authentication layer to access the server. It is advisable to ensure secure encryption of all data within the ElastiCache Replication Group during transit by utilizing an authentication token."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticache-replicationgroup.html
# custom:
#   id: CB_CFT_25
#   severity: MEDIUM

package lib.cloudformation.CB_CFT_25

import future.keywords.in

resource := "AWS::ElastiCache::ReplicationGroup"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass {
	is_valid
	input.Resources[_].Properties.TransitEncryptionEnabled == true
	input.Resources[_].Properties.AuthToken != ""
}

fail {
	is_valid
	not pass
}

passed[result] {
	some i
	pass
	result := {
		"message": "Data is securely encrypted at transit and has auth token.",
		"snippet": {
			"TransitEncryptionEnabled": input.Resources[i].Properties.TransitEncryptionEnabled,
			"AuthToken": input.Resources[i].Properties.AuthToken,
		},
	}
}

failed[result] {
	some i
	fail
	result := {
		"message": "Data should be securely encrypted at transit and have auth token.",
		"snippet": {
			"TransitEncryptionEnabled": input.Resources[i].Properties.TransitEncryptionEnabled,
			"AuthToken": input.Resources[i].Properties.AuthToken,
		},
	}
}
