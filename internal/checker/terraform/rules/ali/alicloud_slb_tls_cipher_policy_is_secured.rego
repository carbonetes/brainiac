# METADATA
# title: "Verify Security of Alibaba Cloud Cypher Policy"
# description: "This policy checks for proper security configurations to safeguard the Alibaba Cloud Cypher Policy, minimizing the risk of unauthorized access or data breaches."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/slb_tls_cipher_policy
# custom:
#   id: CB_TFALI_032
#   severity: LOW
package lib.terraform.CB_TFALI_032

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_slb_tls_cipher_policy" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some unsupported_version in ["TLSv1.1", "TLSv1.0"]
	some tls_version in resource.Attributes.tls_versions
	tls_version == unsupported_version
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Alibaba Cloud Cypher Policy is securely configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Alibaba Cloud Cypher Policy is not securely configured.",
		"snippet": block,
	}
}
