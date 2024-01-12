# METADATA
# title: "Guarantee that the Load Balancer is not accessible from the internet"
# description: "Confirm that the Load Balancer is configured in a manner that prevents exposure to the internet, enhancing network security by limiting accessibility to trusted and specified networks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/data-sources/lb
# custom:
#   id: CB_TFNCP_016
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_016

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_lb" in block.Labels
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
	block.Attributes.network_type == "PRIVATE"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Load Balancer access from the internet is denied.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Load Balancer must not be accessible from the internet.",
		"snippet": block,
	}
}
