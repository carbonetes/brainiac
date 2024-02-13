# METADATA
# title: "Verify that AKS is configured with the Azure Policies Add-on"
# description: "Confirm that AKS (Azure Kubernetes Service) is set up with the Azure Policies Add-on, enhancing governance and compliance by allowing the enforcement of policies and regulatory requirements within the AKS environment"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_118
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_118

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
	resource.Attributes.azure_policy_enabled == true
}

pass[resource] {
	some resource in input
	isvalid(resource)
    some innerBlock in resource.Blocks
	innerBlock.Type == "addon_profile"
    some innermostBlock in innerBlock.Blocks
    innermostBlock.Type == "azure_policy"
    innermostBlock.Attributes.enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "AKS is verified to be configured with the Azure Policies Add-on.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "AKS is not configured with the Azure Policies Add-on as required.",
		"snippet": block,
    }
}
