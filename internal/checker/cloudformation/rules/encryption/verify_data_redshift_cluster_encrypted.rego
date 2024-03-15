# METADATA
# title: "Verify data stored in Redshift cluster are encrypted"
# description: "This policy recommends securely encrypting all data stored in the Redshift cluster at rest. You can achieve this by either creating new encrypted clusters or enabling CMK encryption on existing clusters. AWS suggests enabling encryption during cluster creation or modifying unencrypted clusters to use AWS Key Management Service (AWS KMS) encryption."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-cluster.html
# custom:
#   id: CB_CFT_046
#   severity: HIGH
package lib.cloudformation.CB_CFT_046
import future.keywords.in

resource := "AWS::Redshift::Cluster"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	properties.Encrypted == false
}

pass[resources] {
    resources := input.Resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "All data in Redshift cluster is encrypted",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "All data in Redshift cluster should be encrypted",
		"snippet": block,
	}
}