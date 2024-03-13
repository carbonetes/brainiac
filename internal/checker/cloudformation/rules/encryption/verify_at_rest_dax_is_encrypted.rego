# METADATA
# title: "Verify at rest DAX is encrypted"
# description: "Automate verification to ensure AWS DAX clusters maintain encryption for data at rest."
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dax-cluster.html
# custom:
#   id: CB_CFT_38
#   severity: HIGH
package lib.cloudformation.CB_CFT_38
import future.keywords.in

resource := "AWS::DAX::Cluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties.SSESpecification
    properties.SSEEnabled  == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Dax is encrypted at rest.",
		"snippet": block,
	}
}

failed[result] {
	some resources in fail
	result := {
		"message": "Dax must be encrypted at rest.",
		"snippet": resources,
	}
}
