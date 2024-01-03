# METADATA
# title: "Encrypt Storage Bucket Data-at-Rest"
# description: "This policy ensures that data stored in the storage bucket is encrypted, providing an additional layer of security to sensitive information."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/storage_bucket
# custom:
#   id: CB_TFYC_003
#   severity: LOW
package lib.terraform.CB_TFYC_003

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_storage_bucket" in block.Labels
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
	block.Type == "server_side_encryption_configuration"
	some rule in block.Blocks
	rule.Type == "rule"
	some apply_server_side_encryption_by_default in rule.Blocks
	apply_server_side_encryption_by_default.Type == "apply_server_side_encryption_by_default"
	apply_server_side_encryption_by_default.Attributes.kms_master_key_id != ""
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The storage bucket data is encrypted, meeting the security requirement.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Data in the storage bucket is not encrypted. It is recommended to enable encryption to enhance the security of stored information.",
		"snippet": block,
	}
}
