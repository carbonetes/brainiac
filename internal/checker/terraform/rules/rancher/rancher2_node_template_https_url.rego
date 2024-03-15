# METADATA
# title: "Verify Node Template Configuration Uses HTTPS URL"
# description: "Policy to ensure Rancher2 Node Template URL configuration is using HTTPS"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/node_template
# custom:
#   id: CB_TFRAN_158
#   severity: LOW
package lib.terraform.CB_TFRAN_158

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_node_template" in block.Labels
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
	not startswith(block.Attributes.engine_install_url, "https://")
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Node Template URL uses HTTPS.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 Node Template configurations failed, URL must use HTTPS. Update the configuration accordingly.",
		"snippet": block,
	}
}
