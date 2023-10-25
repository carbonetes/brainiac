# METADATA
# title: "Verify Container Instance Configured with Managed Identity"
# description: "This policy validates that Container Instances are correctly configured with managed identities. Managed identities enhance security and provide a secure way to access Azure resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group
# custom:
#   id: CB_TFAZR_226
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_226

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_container_group" in resource.Labels
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
	some block in resource.Blocks
	block.Type == "identity"
	block.Attributes.type != ""
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "identity"
    	count(split(resource.Attribute.type, "\\s+")) != 0
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Container Instance is properly configured with a managed identity.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Container Instance lacks the necessary configuration for a managed identity.",
		"snippet": block,
	}
}
