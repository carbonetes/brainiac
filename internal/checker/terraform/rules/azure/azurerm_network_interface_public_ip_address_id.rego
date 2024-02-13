# METADATA
# title: "Verify that Network Interfaces are not configured to use public IPs"
# description: "Confirm that Network Interfaces do not utilize public IPs, enhancing network security by preventing exposure to the public internet"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface
# custom:
#   id: CB_TFAZR_122
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_122

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_network_interface" in block.Labels
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
	innerblock.Type == "ip_configuration"
	not innerblock.Attributes.public_ip_address_id
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "Network Interfaces are not configured to use public IPs.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Network Interfaces are configured to use public IPs.",
		"snippet": block,
    }
}
