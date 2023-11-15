# METADATA
# title: "Verify Serial Port Access is Disabled for VM Instances"
# description: "This policy checks that the option to enable connecting to serial ports is turned off for VM instances. Enabling serial port access can pose security risks and should be restricted unless necessary for debugging or troubleshooting."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_from_template
# custom:
#   id: CB_TFGCP_072
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_072

import future.keywords.if
import future.keywords.in

isvalid(block) {
	supported_resources := ["google_compute_instance", "google_compute_instance_from_template", "google_compute_instance_template"]
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

pass[resource] {
	some resource in input
	isvalid(resource)
	pass_con(resource)
}

pass_con(resource) if {
	resource.Attributes.metadata["serial-port-enable"] != true
    not resource.Attributes.source_instance_template
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Serial port access is disabled for all VM instances, reducing potential security risks.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Serial port access is enabled for one or more VM instances. Consider disabling this feature unless necessary for debugging or troubleshooting to minimize security risks.",
		"snippet": block,
	}
}
