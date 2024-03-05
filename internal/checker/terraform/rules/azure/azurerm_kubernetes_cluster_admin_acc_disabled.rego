# METADATA
# title: "Verify that the AKS local admin account is deactivated"
# description: "Confirm that the AKS local admin account is deactivated, enhancing the security of your Azure Kubernetes Service by preventing unauthorized administrative access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_150
#   severity: LOW
package lib.terraform.CB_TFAZR_150

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"azurerm_kubernetes_cluster" in block.Labels
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
	resource.Attributes.local_account_disabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The AKS local admin account is deactivated.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The AKS local admin account is activated, it must be deactivated.",
		"snippet": block,
	}
}
