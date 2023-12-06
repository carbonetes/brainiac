# METADATA
# title: "Verify MongoDB Transparent Data Encryption"
# description: "This policy checks whether Transparent Data Encryption (TDE) is enabled for the MongoDB instance. Enabling TDE enhances data security by encrypting data at rest."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mongodb_instance
# custom:
#   id: CB_TFALI_041
#   severity: LOW
package lib.terraform.CB_TFALI_041

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_mongodb_instance" in block.Labels
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
	resource.Attributes.tde_status == "enabled"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Transparent Data Encryption is enabled for the MongoDB instance, ensuring data at rest is encrypted for enhanced security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Transparent Data Encryption is not enabled for the MongoDB instance, leaving data at rest vulnerable. Enable TDE to enhance data security.",
		"snippet": block,
	}
}
