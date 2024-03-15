# METADATA
# title: "Require Data Explorer/Kusto to Use Managed Identities for Secure Access"
# description: "Ensure that Azure Data Explorer (ADX) or Azure Kusto uses managed identities to access Azure resources securely, enhancing access control and security"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster
# custom:
#   id: CB_TFAZR_157
#   severity: HIGH
package lib.terraform.CB_TFAZR_157

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_kusto_cluster" in block.Labels
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
	innerblock.Type == "identity"
	innerblock.Attributes.type != null
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Azure Data Explorer (ADX) or Azure Kusto is using managed identities to access Azure resources securely, enhancing access control and security.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Azure Data Explorer (ADX) or Azure Kusto should use managed identities to access Azure resources securely, enhancing access control and security.",
		"snippet": block,
	}
}
