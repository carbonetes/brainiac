# METADATA
# title: "Verify that public network access is deactivated for the SQL server"
# description: "Confirm that the SQL server has disabled public network access, enhancing security by preventing unauthorized external connections"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
# custom:
#   id: CB_TFAZR_113
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_113

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_mssql_server" in block.Labels
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
        "message": "Public network access is verified to be deactivated for the SQL server.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Public network access is not deactivated for the SQL server as required.",
		"snippet": block,
    }
}
