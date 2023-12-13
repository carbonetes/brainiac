# METADATA
# title: "Verify MongoDB Instance as Non-Public"
# description: "This policy checks whether the MongoDB instance is configured to be publicly accessible. A secure configuration involves restricting access to the MongoDB instance from the public internet."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/mongodb_instance
# custom:
#   id: CB_TFALI_040
#   severity: LOW
package lib.terraform.CB_TFALI_040

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

fail[resource] {
	some resource in input
	isvalid(resource)
	invalid_security_ips := ["0.0.0.0", "0.0.0.0/0"]
	some ips in resource.Attributes.security_ip_list
	ips in invalid_security_ips
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The MongoDB instance is configured as non-public, ensuring restricted access and enhancing security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The MongoDB instance is configured as public, potentially exposing it to the public internet. Adjust the configuration to restrict access and enhance security.",
		"snippet": block,
	}
}
