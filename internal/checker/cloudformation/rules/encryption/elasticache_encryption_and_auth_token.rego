# METADATA
# title: "Verify all data in ElastiCache Replication Group is encrypted with authentication tokens"
# description: "Authentication becomes feasible solely during the creation of clusters with in-transit encryption activated. With Redis authentication enabled, users are obliged to pass through an extra authentication layer to access the server. It is advisable to ensure secure encryption of all data within the ElastiCache Replication Group during transit by utilizing an authentication token"
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticache-replicationgroup.html
# custom:
#   id: CB_CFT_021
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_021
import future.keywords.in

resource := "AWS::ElastiCache::ReplicationGroup"

is_valid{
	some resources in input.Resources
	resources.Type == resource
}

pass{
	is_valid
	some resources in input.Resources
	resource_properties := resources.Properties
	resource_properties.TransitEncryptionEnabled == true
	not resource_properties.AuthToken == ""
}

fail{
	is_valid
	not pass
}

passed[result]{
	some resources in input.Resources
	pass
	result := {
		"message": "Data is securely encrypted at transit and has auth token",
		"snippet": {
			"TransitEncryptionEnabled": resources.Properties.TransitEncryptionEnabled,
			"AuthToken": resources.Properties.AuthToken,
		},
	}
}

failed[result]{
	some resources in input.Resources
	fail
	result := {
		"message": "Data should be securely encrypted at transit and have auth token",
		"snippet": {
			"TransitEncryptionEnabled": resources.Properties.TransitEncryptionEnabled,
			"AuthToken": resources.Properties.AuthToken,
		},
	}
}