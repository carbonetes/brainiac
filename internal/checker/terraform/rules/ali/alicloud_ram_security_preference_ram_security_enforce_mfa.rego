# METADATA
# title: "Verify RAM Enforces Multi-Factor Authentication (MFA)"
# description: "This policy ensures that Multi-Factor Authentication (MFA) is enforced for RAM (Resource Access Management) accounts. Enforcing MFA adds an additional layer of security to access control."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_security_preference
# custom:
#   id: CB_TFALI_009
#   severity: LOW
package lib.terraform.CB_TFALI_009
import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_ram_security_preference" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	resource.Attributes.enforce_mfa_for_login == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "RAM enforces Multi-Factor Authentication (MFA), enhancing the security posture of access control.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "RAM does not enforce Multi-Factor Authentication (MFA). Enable MFA to strengthen access control security.",
		"snippet": block,
	}
}
