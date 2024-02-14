# METADATA
# title: "Confirm that Cosmos DB inhibits privileged escalation by limiting changes to the management plane"
# description: "Confirm that Cosmos DB is configured to limit changes to the management plane, preventing unauthorized access and privileged escalation. This security measure enhances the protection of sensitive data and resources within your Cosmos DB environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account
# custom:
#   id: CB_TFAZR_129
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_129

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_cosmosdb_account" in block.Labels
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
	resource.Attributes.access_key_metadata_writes_enabled == false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Cosmos DB inhibits privileged escalation by limiting changes to the management plane.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cosmos DB must inhibit privileged escalation by limiting changes to the management plane.",
		"snippet": block,
	}
}
