# METADATA
# title: "Verify Rancher App Custom Annotation Enabled"
# description: "This policy ensures that Rancher2 apps have a specific annotation for additional configuration within the Rancher environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/app
# custom:
#   id: CB_TFRAN_004
#   severity: LOW
package lib.terraform.CB_TFRAN_004

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_app" in block.Labels
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
	"custom_annotation" in object.keys(block.Attributes.annotations)
	block.Attributes.annotations.custom_annotation in ["true", true]
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher app has the required annotation for additional configuration.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher app must have the specified annotation for additional configuration. Update the app configuration accordingly.",
		"snippet": block,
	}
}
