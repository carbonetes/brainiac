# METADATA
# title: "Verify KMS key policy does not have wildcard principal"
# description: "This check verifies whether the KMS key policy contains wildcard (*) principals, which is important for restricting access, adhering to the principle of least privilege, and preventing unauthorized use or misuse of cryptographic keys."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#policy
# custom:
#   id: CB_TFAWS_066
#   severity: HIGH
package lib.terraform.CB_TFAWS_030

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_kms_key"
}

has_attribute(key, value) if {
	value in object.keys(key)
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	has_attribute(resource.Attributes, "policy")
	statement := json.unmarshal(resource.Attributes.policy).Statement[0]
	statement.Effect == "Allow"
	statement.Principal.AWS == "*"
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	has_attribute(resource.Attributes, "policy")
	statement := json.unmarshal(resource.Attributes.policy).Statement[0]
	statement.Effect == "Allow"
	"*" in statement.Principal.AWS
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_kms_key' 'policy' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_kms_key' 'policy' is not set properly.",
		"snippet": block,
	}
}
