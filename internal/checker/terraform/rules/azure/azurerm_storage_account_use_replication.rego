# METADATA
# title: "Storage Account Replication Requirement"
# description: "This policy ensures that Storage Accounts are configured with replication to enhance data redundancy and availability."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
# custom:
#   id: CB_TFAZR_203
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_203

import future.keywords.if
import future.keywords.in

isvalid(block) if {
	block.Type == "resource"
	"azurerm_storage_account" in block.Labels
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
	valid_account_replication_type(resource.Attributes.account_replication_type)
}

valid_account_replication_type("GRS")

valid_account_replication_type("RAGRS")

valid_account_replication_type("GZRS")

valid_account_replication_type("RAGZRS")

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Storage Accounts use replication, ensuring data redundancy and availability.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Storage Accounts should be configured with replication to enhance data redundancy and availability.",
		"snippet": block,
	}
}
