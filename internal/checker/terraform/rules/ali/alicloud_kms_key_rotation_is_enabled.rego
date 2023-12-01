# METADATA
# title: "Verify Key Rotation is Enabled for KMS Keys"
# description: "This policy checks whether key rotation is enabled for Key Management Service (KMS) keys. Enabling key rotation is a security best practice to regularly update cryptographic keys and enhance data protection."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_key
# custom:
#   id: CB_TFALI_017
#   severity: LOW
package lib.terraform.CB_TFALI_017

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_kms_key" in block.Labels
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
	resource.Attributes.automatic_rotation == "Enabled"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Key rotation is enabled for the KMS keys, ensuring a higher level of security through regular updates.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Key rotation is not enabled for the KMS keys. Enable key rotation to adhere to security best practices and enhance data protection.",
		"snippet": block,
	}
}
