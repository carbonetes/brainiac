# METADATA
# title: "Verify Legacy Credentials are set to false"
# description: "This policy verifies legacy credentials setting to ensure they are disabled, promoting adherence to modern authentication standards and enhancing security by mitigating potential risks associated with outdated authentication mechanisms."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cloudant
# custom:
#   id: CB_TFIBM_053
#   severity: HIGH
package lib.terraform.CB_TFIBM_053
import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "ibm_cloudant"
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
	res := resource.Attributes
    res.legacy_credentials == true
}

passed contains result if {
	some block in pass
	result := {
		"message": "Legacy credentials is set to false.",
		"snippet": block
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Legacy credentials must be set to false.",
		"snippet": block,
	}
}
