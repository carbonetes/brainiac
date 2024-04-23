# METADATA
# title: "Verify MFA channel is set"
# description: "This policy verifies the 'active' attribute in the IBM AppID MFA channel resource. It ensures that a specific MFA channel (either email or SMS) is actively configured, thereby enhancing the security of the application."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_idp_mfa_channel
# custom:
#   id: CB_TFIBM_079
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_079

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_appid_mfa_channel" in block.Labels
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
	supportedActiveType(resource)
}

supportedActiveType(block) if {
	supported_types := ["sms", "email"]
	not block.Attributes.active in supported_types
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM AppID MFA (Multi-Factor Authentication) Channel is actively set.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM AppID MFA (Multi-Factor Authentication) Channel is not actively set.",
		"snippet": block,
	}
}
