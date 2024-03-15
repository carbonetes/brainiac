# METADATA
# title: "Verify permissions mode for QLDB ledger is set to STANDARD"
# description: "This policy enables managing ledger databases in Amazon QLDB using the QLDB API or AWS CLI. It facilitates tasks like ledger creation, update, and deletion, as well as listing all ledgers or retrieving specific ledger details."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-qldb-ledger.html
# custom:
#   id: CB_CFT_106
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_106
import future.keywords.in

resource := "AWS::QLDB::Ledger"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
    "PermissionsMode" in object.keys(properties)
	properties.PermissionsMode == "STANDARD"
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "QLDB ledger permissions mode is set to STANDARD",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "QLDB ledger permissions mode not set to STANDARD",
		"snippet": block,
	}
}