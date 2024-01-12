# METADATA
# title: "Verify that Auto Scaling groups linked with a load balancer utilize Load Balancing health checks"
# description: "Guarantee that Auto Scaling groups, which are linked to a load balancer, implement Load Balancing health checks for enhanced operational reliability and performance monitoring."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/auto_scaling_group
# custom:
#   id: CB_TFNCP_017
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_017

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_auto_scaling_group" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_lb_target_group[label] {
	some block in input
	block.Type == "resource"
	"ncloud_lb_target_group" in block.Labels
	label := concat(".", block.Labels)
	some inner_block in block.Blocks
	inner_block.Type == "health_check"
}

lb_target_group_is_attached {
	some block in input
	block.Type == "resource"
	"ncloud_auto_scaling_group" in block.Labels
	some label in label_for_lb_target_group
	contains(block.Attributes.lb_target_group, label)
}

pass[block] {
	expected_values := ["LOADB", "SVR"]
	some block in input
	isvalid(block)
	lb_target_group_is_attached
	block.Attributes.health_check_type_code in expected_values
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Auto Scaling groups linked with a load balancer are utilizing Load Balancing health checks.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Auto Scaling groups linked with a load balancer must utilize Load Balancing health checks.",
		"snippet": block,
	}
}
