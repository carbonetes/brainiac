# METADATA
# title: "Verify that public network access is deactivated for Azure Event Grid Domains"
# description: "Confirm that Azure Event Grid Domains do not allow public network access, enhancing security by restricting access to authorized networks only"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/Devolutions/azurerm/latest/docs/resources/eventgrid_domain
# custom:
#   id: CB_TFAZR_104
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_104

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_eventgrid_domain" in block.Labels
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
        "message": "Public network access is verified to be deactivated for Azure Event Grid Domains.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Public network access is not deactivated for Azure Event Grid Domains as required.",
		"snippet": block,
    }
}

