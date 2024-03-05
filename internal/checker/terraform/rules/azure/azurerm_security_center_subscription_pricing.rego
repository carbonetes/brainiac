# METADATA
# title: "Confirm that the pricing tier selected is standard"
# description: "Verify that the chosen pricing tier is set to `Standard`. This entails ensuring that the pricing plan or level selected for a service or product meets the standard criteria or specifications"
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_subscription_pricing
# custom:
#   id: CB_TFAZR_086
#   severity: LOW
package lib.terraform.CB_TFAZR_086

import future.keywords.in

supportedResources := [
	"azurerm_security_center_subscription_pricing"
]

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
    resource.Attributes.tier == "Standard"
}


fail[resource] {
	some resource in input
	isvalid(resource)
    not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "The standard pricing tier is selected.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "The standard pricing tier is not selected.",
		"snippet": block,
    }
}
