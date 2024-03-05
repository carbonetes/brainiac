# METADATA
# title: "Verify that public network access is disabled for Azure IoT Hub"
# description: "Validate that Azure IoT Hub restricts public network access, enhancing security by preventing unauthorized external connections"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub
# custom:
#   id: CB_TFAZR_106
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_106

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_iothub" in block.Labels
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
	resource.Attributes.public_network_access_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "Public network access is verified to be disabled for Azure IoT Hub.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Public network access is not disabled for Azure IoT Hub as required.",
		"snippet": block,
    }
}
