# METADATA
# title: "Verify that the KMS key policy does not incorporate any wildcard (*) principals."
# description: "A wildcard principal serves as a placeholder granting access to all users or accounts, posing a risk of unauthorized access to your KMS keys. Eliminating wildcard principals from your key policies ensures that only designated users or accounts can access your KMS keys, enhancing key security and mitigating the risk of unauthorized entry."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-kms-key.html
# custom:
#   id: CB_CFT_27
#   severity: HIGH
package lib.cloudformation.CB_CFT_27
import future.keywords.in

resource := "AWS::KMS::Key"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

contains_wildcard_principal(statements) {
	some statement in statements
	statement.Principal == "*"
}

aws_principal(statements) {
	some statement in statements
	statement.Principal.AWS == "*"
}

contains_deny_effect(statements) {
	some statement in statements
	statement.Effect == "Deny"
}

pass[block] {
	is_valid
	some resources in input.Resources
	properties := resources.Properties.KeyPolicy
	statements := properties.Statement
	not aws_principal(statements)
	not contains_wildcard_principal(statements)
	not contains_deny_effect(statements)
	block := [statement | statement := statements]
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "KMS key policy does not contain wildcard (*) principal",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "KMS key policy contains wildcard (*) principal",
		"snippet": block,
	}
}
