# METADATA
# title: "Guarantee the adoption of SSL for RDS instances"
# description: "Verify that the RDS instance employs Secure Sockets Layer (SSL) for enhanced security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance
# custom:
#   id: CB_TFALI_029
#   severity: LOW
package lib.terraform.CB_TFALI_029

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_db_instance" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	valid_ssl_action := [
		"Open",
		"Update",
	]
	block.Attributes.ssl_action in valid_ssl_action
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The RDS instance utilizes Secure Sockets Layer (SSL).",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The RDS instance must utilize Secure Sockets Layer (SSL).",
		"snippet": block,
	}
}
