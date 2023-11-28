# METADATA
# title: "Verify that ingress from all IP addresses (0.0.0.0:0) to port 3389 is not permitted in any security groups"
# description: "Verify that security configurations across all groups prohibit incoming traffic from any IP address (0.0.0.0:0) to port 3389, enhancing the network security posture by preventing unrestricted access to this specific port."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule
# custom:
#   id: CB_TFALI_003
#   severity: HIGH
package lib.terraform.CB_TFALI_003

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_security_group_rule" in block.Labels
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
	block.Attributes.port_range == "3389/3389"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The ingress from all IP addresses (0.0.0.0:0) to port 3389 is not permitted in any security groups.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The ingress from all IP addresses (0.0.0.0:0) to port 3389 should not be permitted in any security groups.",
		"snippet": block,
	}
}
