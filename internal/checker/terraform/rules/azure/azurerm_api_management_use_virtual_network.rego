# METADATA
# title: "Verify that API management services are configured to use virtual networks"
# description: "Validate that API management services are set up to utilize virtual networks. This configuration enhances security and network control by integrating API management with virtual network resources"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/Devolutions/azurerm/latest/docs/resources/api_management
# custom:
#   id: CB_TFAZR_105
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_105

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_api_management" in block.Labels
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
	some innerBlock in resource.Blocks
	innerBlock.Type == "virtual_network_configuration"
	innerBlock.Attributes.subnet_id != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "API management services are verified to be configured to use virtual networks.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "API management services are not configured to use virtual networks as required.",
		"snippet": block,
    }
}

