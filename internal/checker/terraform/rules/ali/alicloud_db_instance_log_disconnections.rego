# METADATA
# title: "Verify Presence of log_disconnections in RDS Instance"
# description: "Verify that log disconnections are enabled for Alibaba Cloud RDS instances, which is crucial for monitoring and auditing connection events."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance
# custom:
#   id: CB_TFALI_034
#   severity: LOW
package lib.terraform.CB_TFALI_034

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
	block.Attributes.name == "log_disconnections"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Alibaba Cloud RDS instance has log disconnections enabled, enhancing monitoring and auditing capabilities.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Alibaba Cloud RDS instance does not have log disconnections enabled, posing a risk to monitoring and auditing capabilities.",
		"snippet": block,
	}
}
