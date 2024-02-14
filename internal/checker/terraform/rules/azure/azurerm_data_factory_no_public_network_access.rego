# METADATA
# title: "Verify that public network access is disabled for Azure Data Factory"
# description: "Confirm that public network access is disabled for Azure Data Factory, enhancing security by restricting access to authorized networks only"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory
# custom:
#   id: CB_TFAZR_102
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_102

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_data_factory" in block.Labels
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
	resource.Attributes.public_network_access == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Public network access is verified to be disabled for Azure Data Factory.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Public network access is not disabled for Azure Data Factory.",
		"snippet": block,
	}
}
