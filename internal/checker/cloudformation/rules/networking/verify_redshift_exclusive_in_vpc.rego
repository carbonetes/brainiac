# METADATA
# title: "Verify that Redshift is deployed exclusively within a VPC"
# description: "This policy involves deploying Redshift within a VPC to regulate inbound and outbound network traffic using security groups and NACLs, enhancing cluster security and protecting against unauthorized access or attacks."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-cluster.html
# custom:
#   id: CB_CFT_094
#   severity: LOW
package lib.cloudformation.CB_CFT_094
import future.keywords.in

resource := "AWS::Redshift::Cluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
    properties := resources.Properties
    properties.ClusterSubnetGroupName != ""
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := {
		"message": "Redshift is not deployed outside VPC.",
		"snippet": properties,
	}
}

failed[result] {
	some properties in fail
	result := {
		"message": "Redshift is deployed outside VPC.",
		"snippet": properties,
	}
}
