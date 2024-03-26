# METADATA
# title: "Verify that EC2 user data doesn't contain any hard-coded secrets"
# description: "Removing secrets from unencrypted locations reduces the risk of exposing sensitive information to unauthorized parties."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
# custom:
#   id: CB_TFAWS_048
#   severity: HIGH
package lib.terraform.CB_TFAWS_048

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_instance"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

fail contains block if {
	some block in input
	isvalid(block)
	block.Type == "resource"
	user_data := block.Attributes.user_data
	key := ["access_key", "secret_key"]
	some k in key
	contains(user_data, k)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "No secrets found in EC2 user data.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Secrets should not exist in an EC2 user data.",
		"snippet": block,
	}
}