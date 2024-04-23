# METADATA
# title: "Verify MFA channel sms is properly configured"
# description: "This policy verifies that the 'sms_config' block and its attributes 'key', 'secret', and 'from' exist in the IBM AppID MFA channel resource. It ensures that the SMS configuration for Multi-Factor Authentication (MFA) is properly set, enhancing the security of the application."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_idp_mfa_channel
# custom:
#   id: CB_TFIBM_080
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_080

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
	smsConfigExists(resource)
}

smsConfigExists(block) if {
	some sms_config in block.Blocks
	sms_config.Type == "sms_config"
	not sms_config.Attributes.key
	not sms_config.Attributes.secret
	not sms_config.Attributes.from
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM AppID MFA channel SMS configuration is properly configured.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM AppID MFA (Multi-Factor Authenticatio) channel SMS configuration is not properly configured.",
		"snippet": block,
	}
}
