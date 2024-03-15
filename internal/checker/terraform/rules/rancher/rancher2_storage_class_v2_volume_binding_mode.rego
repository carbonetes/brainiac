# METADATA
# title: "Verify Rancher2 Storage Class v2 Volume Binding Mode"
# description: "Policy to verify Rancher2 Storage Class v2 Volume Binding Mode, ensuring that the volume binding mode for storageClass v2 is specified correctly."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/storage_class_v2
# custom:
#   id: CB_TFRAN_185
#   severity: LOW
package lib.terraform.CB_TFRAN_185

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_storage_class_v2" in block.Labels
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
	not volume_binding_mode(block)
}

volume_binding_mode(block) {
	allowed_values := [
		"Immediate",
		"WaitForFirstConsumer",
	]
	block.Attributes.volume_binding_mode in allowed_values
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Storage Class v2 Volume Binding Mode has been successfully validated with the specified volume binding mode.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Storage Class v2 Volume Binding Mode configuration. Ensure that the volume binding mode is specified correctly, allowing values such as Immediate and WaitForFirstConsumer.",
		"snippet": block,
	}
}
