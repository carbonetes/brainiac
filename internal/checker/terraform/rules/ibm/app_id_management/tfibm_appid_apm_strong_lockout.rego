# METADATA
# title: "Verify strong lockout policy"
# description: "This policy validates that the 'lockout_policy' in the 'ibm_appid_apm' resource is strong enough to mitigate brute force attacks. It checks if the lockout policy is enabled, if the lockout timeout is at least 1800 seconds, and if the number of invalid attempts before lockout is not more than 3. Implementing strong lockout policies and other security controls enchances the security of the configuration."
# scope: package"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_apm
# custom:
#   id: CB_TFIBM_050
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_050

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_appid_apm" in block.Labels
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	hasStrongLockoutPolicy(resource)
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not hasStrongLockoutPolicy(resource)
}

hasStrongLockoutPolicy(block) if {
	some type in block.Blocks
	type.Type == "lockout_policy"
	type.Attributes.enabled == true
	some lockout in block.Blocks
	to_number(lockout.Attributes.lockout_time_sec) >= 1800
	to_number(lockout.Attributes.num_of_attempts) <= 3
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM AppID APM resource has a strong 'lockout_policy', reducing the risk of brute force attacks.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM AppID APM resource has a weak 'lockout_policy', leading to security risks due to brute force attacks.",
		"snippet": block,
	}
}
