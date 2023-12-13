# METADATA
# title: "Verify Alibaba Cloud RDS Log Audit Configuration"
# description: "Ensure that log audit is enabled for Alibaba Cloud RDS instances. Log audit provides a detailed record of database activities, helping in security and compliance monitoring."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/log_audit
# custom:
#   id: CB_TFALI_037
#   severity: LOW
package lib.terraform.CB_TFALI_037

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_log_audit" in block.Labels
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
	resource.Attributes.variable_map.rds_enabled == "true"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Alibaba Cloud RDS instance has log audit enabled, contributing to enhanced security and compliance monitoring.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Alibaba Cloud RDS instance does not have log audit enabled. Enable log audit to enhance security and compliance monitoring.",
		"snippet": block,
	}
}
