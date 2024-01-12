# METADATA
# title: "Encrypt etcd Database with KMS Key"
# description: "This policy ensures that the etcd database is encrypted using a Key Management Service (KMS) key. Encrypting the etcd database with a KMS key enhances the security of the stored data, protecting it from unauthorized access."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFYC_010
#   severity: HIGH
package lib.terraform.CB_TFYC_010

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_kubernetes_cluster" in block.Labels
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
	some block in resource.Blocks
	block.Type == "kms_provider"
	block.Attributes.key_id != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The etcd database is successfully encrypted with a KMS key, providing an additional layer of security to the stored data.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The etcd database lacks encryption with a KMS key. It is crucial to configure encryption to safeguard sensitive information stored in the etcd database.",
		"snippet": block,
	}
}
