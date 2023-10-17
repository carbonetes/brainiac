# METADATA
# title: "Verify container image quarantine, scan, and mark images verified"
# description: "This policy is designed to enhance the security of container images within the deployment pipeline by verifying that a comprehensive process is in place."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
# custom:
#   id: CB_TFAZR_185
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_185

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_container_registry" in block.Labels
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
	block.Attributes.quarantine_policy_enabled == true
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Container image quarantine, scan, and mark images as verified is enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Container image quarantine, scan, and mark images as verified is not enabled.",
		"snippet": block,
	}
}