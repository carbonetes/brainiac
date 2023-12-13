# METADATA
# title: "Verify Presence of log_connections in RDS Instance"
# description: "Ensure that log connections are enabled for Alibaba Cloud RDS instances, providing crucial information for monitoring and auditing connection events."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance
# custom:
#   id: CB_TFALI_035
#   severity: LOW
package lib.terraform.CB_TFALI_035

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
	block.Attributes.name == "log_connections"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Alibaba Cloud RDS instance has log connections enabled, enhancing monitoring and auditing capabilities.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Alibaba Cloud RDS instance does not have log connections enabled, posing a risk to monitoring and auditing capabilities.",
		"snippet": block,
	}
}
