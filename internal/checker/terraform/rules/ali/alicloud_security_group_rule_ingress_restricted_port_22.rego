# METADATA
# title: "Verify that ingress from all IP addresses (0.0.0.0:0) to port 22 is not permitted in any security groups"
# description: "Verify that security configurations across all groups prohibit incoming traffic from any IP address (0.0.0.0:0) to port 22, enhancing the network security posture by preventing unrestricted access to this specific port."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule
# custom:
#   id: CB_TFALI_002
#   severity: HIGH
package lib.terraform.CB_TFALI_002

import future.keywords.in
import future.keywords.if

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
	block.Attributes.type == "ingress"
	check_port_range(block)
	check_cidr_ip(block)

}

check_cidr_ip(block) := true if {
	block.Attributes.cidr_ip == "0.0.0.0/0"
} else := true if {
	"0.0.0.0/0" in block.Attributes.cidr_ip
} 

check_port_range(block) := true if {
	block.Attributes.port_range == "22"
} else := true if {
	"22" in block.Attributes.port_range
} else := true if {
 to_number(block.Attributes.port_range) == 22
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The ingress from all IP addresses (0.0.0.0:0) to port 22 is not permitted in any security groups.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The ingress from all IP addresses (0.0.0.0:0) to port 22 should not be permitted in any security groups.",
		"snippet": block,
	}
}
