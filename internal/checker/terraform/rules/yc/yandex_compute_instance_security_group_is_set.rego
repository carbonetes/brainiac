# METADATA
# title: "Assign Security Group to Network Interface"
# description: "This policy ensures that a security group is properly assigned to a network interface. Assigning security groups to network interfaces helps control inbound and outbound traffic, adding an essential layer of network security."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/compute_instance
# custom:
#   id: CB_TFYC_011
#   severity: MEDIUM
package lib.terraform.CB_TFYC_011

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_compute_instance" in block.Labels
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
	block.Type == "network_interface"
	count(block.Attributes.security_group_ids) != 0
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The security group is successfully assigned to the network interface, enhancing the security of the associated resources by controlling network traffic effectively.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The network interface does not have a security group assigned. It is crucial to associate a security group to control network traffic and enforce security measures.",
		"snippet": block,
	}
}
