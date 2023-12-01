# METADATA
# title: "Verify RDS Instance SQL Collector Retention Period Exceeds 180 Days"
# description: "This policy ensures that the retention period for the SQL collector in RDS instances is set to a value greater than 180 days. A longer retention period helps in preserving historical data for a more extended duration."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance
# custom:
#   id: CB_TFALI_010
#   severity: LOW
package lib.terraform.CB_TFALI_010

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
	to_number(resource.Attributes.sql_collector_config_value) >= 180
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The RDS Instance SQL Collector retention period is configured for more than 180 days, meeting the policy requirements.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The RDS Instance SQL Collector retention period is set to 180 days or less. Increase the retention period to meet the policy requirements and retain data for a longer duration.",
		"snippet": block,
	}
}
