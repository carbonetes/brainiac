# METADATA
# title: "Verify that the instance doesn't employ basic credentials"
# description: "Confirm that  instances are not configured to utilize basic credentials, which could pose a security risk. Basic credentials are typically simple and easily guessable, making them vulnerable to unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_instance_v2
# custom:
#   id: CB_TFOPENSTACK_004
#   severity: MEDIUM
package lib.terraform.CB_TFOPENSTACK_004

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"openstack_compute_instance_v2" in block.Labels
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
	block.Attributes.admin_pass != ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The attribute 'admin_pass' is either not present or has an empty string.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The attribute 'admin_pass' must not be present, or must have an empty string.",
		"snippet": block,
	}
}
