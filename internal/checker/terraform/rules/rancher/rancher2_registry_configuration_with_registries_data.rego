# METADATA
# title: "Verify Rancher2 Registry Configuration with Registries Data"
# description: "Policy to verify that the Rancher2 registry configuration includes the required data for the registries."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/registry
# custom:
#   id: CB_TFRAN_113
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_113

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_registry" in block.Labels
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
	some innerblock in block.Blocks
	innerblock.Type == "registries"
	innerblock.Attributes.address != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 registry configuration contains all required data for the registries.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 registry configuration detected. Please ensure all required data for the registries is included.",
		"snippet": block,
	}
}
