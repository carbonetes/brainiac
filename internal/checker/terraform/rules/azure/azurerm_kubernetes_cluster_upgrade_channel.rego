# METADATA
# title: "Select an upgrade channel for the AKS cluster"
# description: "Ensure that an upgrade channel is chosen for the AKS cluster to manage its update and maintenance process effectively"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_139
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_139

import future.keywords.in

supportedResources := ["azurerm_kubernetes_cluster"]

isvalid(block) {
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
	resource.Attributes.automatic_channel_upgrade != "none"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "An upgrade channel has been selected for the AKS cluster."
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "An upgrade channel must be selected for the AKS cluster."
    }
}