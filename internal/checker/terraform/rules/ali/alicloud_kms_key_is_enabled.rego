# METADATA
# title: "Verify KMS Keys are Enabled"
# description: "This policy checks whether Key Management Service (KMS) keys are enabled. Enabling keys is crucial for cryptographic operations and ensuring the security of sensitive data."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/kms_key
# custom:
#   id: CB_TFALI_018
#   severity: LOW
package lib.terraform.CB_TFALI_018

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
	resource.Attributes.status == "Enabled"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "KMS keys are enabled, ensuring cryptographic operations and maintaining the security of sensitive data.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "KMS keys are not enabled. Enable keys to enable cryptographic operations and enhance the security of sensitive data.",
		"snippet": block,
	}
}
