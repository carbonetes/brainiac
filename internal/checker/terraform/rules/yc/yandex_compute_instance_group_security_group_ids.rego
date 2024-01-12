# METADATA
# title: "Verify Security Group Assignment for Compute Instance Group"
# description: "This policy ensures that a security group is properly assigned to a compute instance group, enhancing the security posture of the deployment."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/compute_instance_group
# custom:
#   id: CB_TFYC_022
#   severity: LOW
package lib.terraform.CB_TFYC_022

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_compute_instance_group" in block.Labels
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
	block.Type == "instance_template"
	some network_interface in block.Blocks
	network_interface.Type == "network_interface"
	count(network_interface.Attributes.security_group_ids) != 0
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The compute instance group has a security group properly assigned, meeting security requirements.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The compute instance group does not have a security group assigned, which poses a security risk. Please ensure a security group is properly configured for the compute instance group.",
		"snippet": block,
	}
}
