# METADATA
# title: "Verify Redshift cluster is private."
# description: "Ensure Redshift cluster privacy by verifying the 'PubliclyAccessible' property is set to 'false' in its configuration."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-cluster.html
# custom:
#   id: CB_CFT_068
#   severity: HIGH
package lib.cloudformation.CB_CFT_068
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
    properties.PubliclyAccessible == false
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some properties in pass
	result := {
		"message": "Redshift Cluster  is not publicly accessible.",
		"snippet": properties,
	}
}

failed[result] {
	some properties in fail
	result := {
		"message": "Redshift Cluster is publicly accessible.",
		"snippet": properties,
	}
}
