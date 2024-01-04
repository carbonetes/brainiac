# METADATA
# title: "Disallow Public IP for Compute Instance"
# description: "This policy ensures that compute instances do not have a public IP address. Disallowing public IP addresses enhances security by reducing exposure to potential threats."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/compute_instance
# custom:
#   id: CB_TFYC_002
#   severity: LOW
package lib.terraform.CB_TFYC_002

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

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "network_interface"
	true in block.Attributes.nat
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The compute instance does not have a public IP, meeting the security requirement.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "A public IP is assigned to the compute instance. It is recommended to remove the public IP to enhance security and reduce potential vulnerabilities",
		"snippet": block,
	}
}
