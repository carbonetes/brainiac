# METADATA
# title: "Verify that Azure Data Explorer uses disk encryption"
# description: "This policy is designed to enhance the security and data protection of Azure Data Explorer by verifying that disk-level encryption is applied."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster
# custom:
#   id: CB_TFAZR_039
#   severity: LOW
package lib.terraform.CB_TFAZR_039

import future.keywords.in

isvalid(resource) {
	resource.Type == "resource"
	"azurerm_kusto_cluster" in resource.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
    some block in input
	isvalid(block)
	block.Attributes.enable_disk_encryption == true
}

fail[block] {
    some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
    some block in pass
	result := {
		"message": "Azure Data Explorer uses disk encryption.",
		"snippet": block,
	}
}

failed[result] {
    some block in fail
	result := {
		"message": "Azure Data Explorer does not use disk encryption.",
		"snippet": block,
	}
}