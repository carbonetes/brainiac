# METADATA
# title: "Avoid Public IP for Compute Instance Group"
# description: "This policy ensures that a compute instance group does not have a public IP assigned. Public IPs can expose instances to potential security threats and unauthorized access."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/compute_instance_group
# custom:
#   id: CB_TFYC_018
#   severity: MEDIUM
package lib.terraform.CB_TFYC_018

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
	network_interface.Attributes.nat != true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The compute instance group is configured without a public IP, enhancing security by minimizing exposure to external networks.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "A public IP is detected for the compute instance group. It is recommended to remove the public IP to reduce the risk of security vulnerabilities.",
		"snippet": block,
	}
}
