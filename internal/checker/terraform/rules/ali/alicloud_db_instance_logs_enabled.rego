# METADATA
# title: "Verify Presence of log_duration in RDS Instance"
# description: "This policy ensures that the log_duration setting is configured for RDS instances."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance
# custom:
#   id: CB_TFALI_033
#   severity: LOW
package lib.terraform.CB_TFALI_033

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

pass[resource] {
	some resource in input
	isvalid(resource)
    some block in resource.Blocks
    block.Type == "parameter"
    block.Attributes.name == "log_duration"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The log_duration setting is configured for the RDS instance.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The log_duration setting is missing in the configuration of the RDS instance.",
		"snippet": block,
	}
}
