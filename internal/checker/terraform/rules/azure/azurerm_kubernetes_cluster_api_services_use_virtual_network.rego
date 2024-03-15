# METADATA
# title: "Verify that AKS has private clusters enabled"
# description: "Confirm that AKS (Azure Kubernetes Service) is configured with the private cluster feature enabled. This enhances security by ensuring that the Kubernetes cluster's control plane and nodes are only accessible from within a private network, reducing exposure to external threats"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFAZR_117
#   severity: MEDIUM
package lib.terraform.CB_TFAZR_117

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
	resource.Attributes.private_cluster_enabled == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
    some block in pass
    result := {
        "message": "Private clusters are verified to be enabled for AKS.",
		"snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Private clusters are not enabled for AKS as required.",
		"snippet": block,
    }
}