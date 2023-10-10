# METADATA
# title: "Verify Public Access disabled for App Configuration"
# description: "Ensure that 'Public Access' is not enabled for App Configuration to prevent unauthorized access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration
# custom:
#   id: CB_TFAZR_164
#   severity: HIGH
package lib.terraform.CB_TFAZR_164

import future.keywords.in

supportedResources := ["azurerm_app_configuration"]

isvalid(block) {
	block.Type == "resource"
	some label in block.Labels
	label in supportedResources
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
	resource.Attributes.public_network_access == "Disabled"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {"message": "Public access is not enabled for App Configuration, ensuring restricted access."}
}

failed[result] {
	some block in fail
	result := {"message": "Public access should not be enabled for App Configuration to prevent unauthorized access."}
}
