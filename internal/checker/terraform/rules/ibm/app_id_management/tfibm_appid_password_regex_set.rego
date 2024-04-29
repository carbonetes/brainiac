# METADATA
# title: "Verify password regex is set"
# description: "This policy verifies that the password regex expression is set for IBM Cloud AppID Management Services. It ensures that the regex expression used for acceptable passwords is defined and raises a failure if the regex expression is missing."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_password_regex
# custom:
#   id: CB_TFIBM_081
#   severity: LOW
package lib.terraform.CB_TFIBM_081

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_appid_password_regex" in block.Labels
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
	not fail[resource]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	invalidRegex(resource)
}

invalidRegex(block) if {
	not block.Attributes.regex
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM AppID Regex password regex is set.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM AppID Regex password regex is not set.",
		"snippet": block,
	}
}
