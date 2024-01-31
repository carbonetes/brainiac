# METADATA
# title: "Verify that security groups don't permit incoming traffic from 0.0.0.0:0 to port 3389 (TCP/UDP)"
# description: "Confirm that no security groups permit inbound traffic from any IP address (0.0.0.0:0) to port 3389, whether it's TCP or UDP protocol."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_secgroup_v2
# custom:
#   id: CB_TFOPENSTACK_003
#   severity: MEDIUM
package lib.terraform.CB_TFOPENSTACK_003

import future.keywords.in

isvalid(block) {
	supported_resources := ["openstack_compute_secgroup_v2", "openstack_networking_secgroup_rule_v2"]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
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
	block.Attributes.port_range_min == "3389"
	block.Attributes.remote_ip_prefix == "0.0.0.0/0"
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The incoming traffic from 0.0.0.0:0 to port 3389 is not permitted.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The incoming traffic from 0.0.0.0:0 to port 3389 must not be permitted.",
		"snippet": block,
	}
}
