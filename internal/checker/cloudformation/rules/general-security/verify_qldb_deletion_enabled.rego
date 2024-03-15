# METADATA
# title: "Verify deletion protection for QLDB ledger is enabled"
# description: "This policy pertains to Amazon Quantum Ledger Database (Amazon QLDB), a fully managed ledger database. It allows for cryptographically verifiable transaction logging. The QLDB API or AWS Command Line Interface (CLI) facilitates ledger management, including creation, updates, and deletions. Deletion protection is enabled by default. To delete a ledger via Terraform, set `deletion_protection` to `false`. In CloudFormation, this protection prevents ledger deletion. If not specified during ledger creation, deletion protection defaults to enabled (true)."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-qldb-ledger.html
# custom:
#   id: CB_CFT_107
#   severity: LOW
package lib.cloudformation.CB_CFT_107
import future.keywords.in

resource := "AWS::QLDB::Ledger"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
	properties.DeletionProtection != false
}

pass[properties]{
 	some resource in input.Resources
    properties := resource.Properties
    not "DeletionProtection" in object.keys(properties)
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "QLDB ledger have deletion protection enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "QLDB ledger has no deletion protection enabled",
		"snippet": block,
	}
}