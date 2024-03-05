# METADATA
# title: "Verify the presence of a retention policy for cleaning up untagged manifests"
# description: "Confirm that a retention policy is in place to remove untagged manifests"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
# custom:
#   id: CB_TFAZR_135
#   severity: LOW
package lib.terraform.CB_TFAZR_135

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

pass[resource] {
	some resource in input
	isvalid(resource)
	some innerblock in resource.Blocks
	innerblock.Type == "retention_policy"
	innerblock.Attributes.enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "A retention policy for cleaning up untagged manifests is present and enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "No retention policy should be enabled for cleaning up untagged manifests.",
		"snippet": block,
	}
}
