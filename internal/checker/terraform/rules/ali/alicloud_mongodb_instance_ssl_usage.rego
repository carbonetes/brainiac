# METADATA
# title: "Verify MongoDB Instance SSL Usage"
# description: "This policy checks whether the MongoDB instance is configured to use SSL (Secure Sockets Layer). Enabling SSL ensures encrypted communication, enhancing the security of data transmission."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mongodb_instance
# custom:
#   id: CB_TFALI_039
#   severity: LOW
package lib.terraform.CB_TFALI_039

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
	some ssl_actions in ["Open", "Update"]
	ssl_actions == resource.Attributes.ssl_action
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The MongoDB instance is configured to use SSL, providing secure and encrypted communication.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The MongoDB instance is not configured to use SSL, leaving data transmission vulnerable to interception. Enable SSL for enhanced security.",
		"snippet": block,
	}
}
