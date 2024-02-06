# METADATA
# title: "Verify AKS Configuration for Rancher2 Cluster"
# description: "This policy ensures that the Rancher2 Cluster includes a valid Azure AKS (Azure Kubernetes Service) configuration. AKS configuration is essential for defining and managing Kubernetes clusters hosted on the Azure cloud platform."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster
# custom:
#   id: CB_TFRAN_062
#   severity: LOW
package lib.terraform.CB_TFRAN_062

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster" in block.Labels
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
	aks_config(block)
}

pass[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
    some innerblock in block.Blocks
	not innerblock.Type == "aks_config"
}

aks_config(block) {
    conflict_configs := [
        "aks_config_v2",
        "eks_config",
        "eks_config_v2",
        "gke_config",
        "gke_config_v2",
        "oke_config",
		"k3s_config",
		"rke_config"
    ]
    some innerblock in block.Blocks
	innerblock.Type == "aks_config"
    not innerblock.Type in conflict_configs
	count(block.Blocks) == 1
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Rancher2 Cluster includes a valid AKS configuration, ensuring proper setup and management of the Kubernetes cluster on the Azure cloud platform.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Rancher2 Cluster does not have a valid AKS configuration provided. Please ensure that the AKS configuration is correctly specified to facilitate proper setup and management of the Kubernetes cluster on the Azure cloud platform.",
		"snippet": block,
	}
}
