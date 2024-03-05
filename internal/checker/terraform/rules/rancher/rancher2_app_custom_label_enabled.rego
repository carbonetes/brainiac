# METADATA
# title: "Verify Rancher2 App Custom Label Presence"
# description: "This policy ensures that Rancher2 apps have a specific custom label for proper configuration within the Rancher environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/app
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/app_v2
# custom:
#   id: CB_TFRAN_005
#   severity: LOW
package lib.terraform.CB_TFRAN_005

import future.keywords.in

isvalid(block) {
	supported_resources := ["rancher2_app", "rancher2_app_v2"]
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

pass[block] {
	some block in input
	isvalid(block)
	"custom_label" in object.keys(block.Attributes.labels)
    block.Attributes.labels.custom_label in ["true", true]
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 app has the required custom label for proper configuration.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 app must have the specified custom label for proper configuration. Update the app configuration accordingly.",
		"snippet": block,
	}
}
