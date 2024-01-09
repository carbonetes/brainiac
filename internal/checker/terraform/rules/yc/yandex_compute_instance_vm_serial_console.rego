# METADATA
# title: "Disable Serial Console for Compute Instances"
# description: "This policy ensures that the serial console is disabled for compute instances, reducing the potential attack surface and enhancing security."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/compute_instance
# custom:
#   id: CB_TFYC_004
#   severity: LOW
package lib.terraform.CB_TFYC_004

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
    resource.Attributes.metadata["serial-port-enable"] == true
    
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Serial console is disabled for the compute instance, meeting security best practices.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Serial console is enabled for the compute instance. It is recommended to disable it to enhance security and reduce the risk of unauthorized access.",
		"snippet": block,
	}
}
