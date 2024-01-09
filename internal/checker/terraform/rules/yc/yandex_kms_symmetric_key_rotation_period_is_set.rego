# METADATA
# title: "Rotate KMS Symmetric Key"
# description: "This policy ensures that a Key Management Service (KMS) symmetric key undergoes regular rotation. Key rotation is a security best practice that helps mitigate potential risks by generating a new key while retaining access to the existing one during the transition."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/kms_symmetric_key
# custom:
#   id: CB_TFYC_009
#   severity: MEDIUM
package lib.terraform.CB_TFYC_009

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_kms_symmetric_key" in block.Labels
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
	resource.Attributes.rotation_period != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The KMS symmetric key is configured for regular rotation, enhancing security through the consistent renewal of cryptographic material.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The KMS symmetric key is not configured for regular rotation. It is crucial to enable key rotation to maintain a robust security posture.",
		"snippet": block,
	}
}
