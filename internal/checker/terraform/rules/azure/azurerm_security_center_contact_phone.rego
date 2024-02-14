# METADATA
# title: "Confirm that the 'Phone number' is configured for the security contact"
# description: "Validate that a 'Phone number' is provided and configured for the security contact. This ensures that there is a valid and reachable contact number associated with security-related matters"
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/security_center_contact
# custom:
#   id: CB_TFAZR_087
#   severity: LOW
package lib.terraform.CB_TFAZR_087

import future.keywords.in

supportedResources := [
	"azurerm_security_center_contact"
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
    resource.Attributes.phone != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
    not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "The 'Phone number' is configured for the security contact.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "The 'Phone number' is not configured for the security contact.",
		"snippet": block,
    }
}
