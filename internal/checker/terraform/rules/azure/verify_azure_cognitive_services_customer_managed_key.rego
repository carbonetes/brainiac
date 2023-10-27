# METADATA
# title: "Verify that Cognitive Services enables customer-managed key for encryption"
# description: "This policy is designed to enhance the security and data protection of Cognitive Services by verifying that customer-managed keys are enabled for encryption."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cognitive_account
# custom:
#   id: CB_TFAZR_239
#   severity: LOW
package lib.terraform.CB_TFAZR_239

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_cognitive_account" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_cognitive_account[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_cognitive_account" in resource.Labels
	label := concat(".", resource.Labels)
}

label_for_key_vault_key[label] {
	some resource in input
	resource.Type == "resource"
	"azurerm_key_vault_key" in resource.Labels
	label := concat(".", resource.Labels)
}

is_cognitive_account_attached {
	some block in input
	block.Type == "resource"
	"azurerm_cognitive_account_customer_managed_key" in block.Labels
	some label in label_for_cognitive_account
	contains(block.Attributes.cognitive_account_id, label)
}

is_cognitive_account_customer_managed_key_attached {
	some block in input
	block.Type == "resource"
	"azurerm_cognitive_account_customer_managed_key" in block.Labels
	some label in label_for_key_vault_key
	contains(block.Attributes.key_vault_key_id, label)
}

pass[block] {
	some block in input
	isvalid(block)
	is_cognitive_account_attached
	is_cognitive_account_customer_managed_key_attached
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Cognitive Services enable customer-managed keys for encryption.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Cognitive Services do not enable customer-managed keys for encryption.",
		"snippet": block,
	}
}