# METADATA
# title: "Verify that the provider has no hard-coded AWS access keys or secret keys"
# description: "Avoid storing hardcoded keys and secrets in infrastructure code or version-controlled configuration settings."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs
# custom:
#   id: CB_TFAWS_054
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_054

import rego.v1

isvalid(block) if {
	block.Type == "provider"
	some label in block.Labels
	label == "aws"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

checkRegex(block) if {
	regex.match(`[A-Z0-9]{20}`, block.Attributes.access_key)
}

checkRegex(block) if {
	regex.match(`[a-zA-Z0-9/+]{40}`, block.Attributes.secret_key)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	checkRegex(resource)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Hard-coded AWS access keys or secret keys not found.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Do not include hard-coded AWS access keys or secret keys.",
		"snippet": block,
	}
}





