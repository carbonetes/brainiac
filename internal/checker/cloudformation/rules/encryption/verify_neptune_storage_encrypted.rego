# METADATA
# title: "Verify Neptune storage is encrypted"
# description: "This policy ensures that Amazon Neptune, a fully managed graph database service, supports graph query languages like Apache TinkerPop Gremlin and W3C's SPARQL, catering to various applications such as recommendation engines, fraud detection, and network security. Encrypting Neptune's storage protects both data and metadata from unauthorized access, satisfying compliance requirements for data-at-rest encryption. Notably, encryption cannot be added or modified for an existing database after creation."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-neptune-dbcluster.html
# custom:
#   id: CB_CFT_030
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_030
import future.keywords.in

resource := "AWS::Neptune::DBCluster"

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
		"message": "Neptune storage is encrypted",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Neptune storage should be encrypted",
		"snippet": block,
	}
}