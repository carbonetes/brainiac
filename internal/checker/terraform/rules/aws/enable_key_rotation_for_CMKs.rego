# METADATA
# title: "Enable key rotation for customer-created Customer Master Keys (CMKs)"
# description: "This reduces the risk of compromised keys as well as the amount of time an attacker has to exploit any vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key#enable_key_rotation
# custom:
#   id: CB_TFAWS_006
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_006

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_kms_key"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.enable_key_rotation == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_kms_key' 'enable_key_rotation' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_kms_key' 'enable_key_rotation' should be set to true",
		"snippet": block,
	}
}
