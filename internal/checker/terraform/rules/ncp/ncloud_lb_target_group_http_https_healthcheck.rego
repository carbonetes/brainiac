# METADATA
# title: "Verify that the target group using HTTP or HTTPS protocols has a specified health check"
# description: "Confirm the Target Group for HTTP and HTTPS protocols includes a specified health check configuration, providing a mechanism to assess and maintain the health of the associated resources."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/lb_target_group
# custom:
#   id: CB_TFNCP_001
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_001

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_lb_target_group" in block.Labels
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
	expected_values := [
		"HTTPS",
		"HTTP",
	]
	block.Attributes.protocol in expected_values
	some inner_block in block.Blocks
	inner_block.Type == "health_check"
	"url_path" in object.keys(inner_block.Attributes)
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The target group using HTTP or HTTPS protocols has a specified health check.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The target group using HTTP or HTTPS protocols must have a health check specified.",
		"snippet": block,
	}
}
