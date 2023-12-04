# METADATA
# title: "Confirm that the database instance is not accessible to the public"
# description: "Verify that the database instance is configured to restrict public access, enhancing security measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance
# custom:
#   id: CB_TFALI_013
#   severity: LOW
package lib.terraform.CB_TFALI_013

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

fail[block] {
	some block in input
	isvalid(block)
	invalid_security_ips := ["0.0.0.0", "0.0.0.0/0"]
	some ips in block.Attributes.security_ips
	ips in invalid_security_ips
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The database instance is not accessible to the public.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The database instance must not be accessible to the public.",
		"snippet": block,
	}
}
