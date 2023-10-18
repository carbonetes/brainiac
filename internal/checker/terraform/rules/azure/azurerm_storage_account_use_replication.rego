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

supportedResources := ["azurerm_storage_account"]

isvalid(block) if {
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
	validAccountReplicationType(resource.Attributes.account_replication_type)
}

validAccountReplicationType(type) if {
	type == "GRS"
} else if {
	type == "RAGRS"
} else if {
	type == "GZRS"
} else if {
	type == "RAGZRS"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {"message": "Storage Accounts use replication, ensuring data redundancy and availability."}
}

failed[result] {
	some block in fail
	result := {"message": "Storage Accounts should be configured with replication to enhance data redundancy and availability."}
}
