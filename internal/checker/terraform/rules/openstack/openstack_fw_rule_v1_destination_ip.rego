# METADATA
# title: "Verify that firewall rules define a destination IP address"
# description: "Confirm that firewall rules are configured with a destination IP address specified. Setting a destination IP address helps in precisely defining the target location for the firewall rule, thereby enhancing network security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/fw_rule_v1
# custom:
#   id: CB_TFOPENSTACK_005
#   severity: LOW
package lib.terraform.CB_TFOPENSTACK_005

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"openstack_fw_rule_v1" in block.Labels
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
	"destination_ip_address" in object.keys(block.Attributes)
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The firewall rules include a destination IP address.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The firewall rules must include a destination IP address.",
		"snippet": block,
	}
}
