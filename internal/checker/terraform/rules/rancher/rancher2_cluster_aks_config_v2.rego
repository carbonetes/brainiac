# METADATA
# title: "Verify AKS Configuration V2 for Rancher2 Cluster"
# description: "This policy verifies that the AKS (Azure Kubernetes Service) Configuration V2 is correctly provided for Rancher2 Clusters. The AKS configuration is essential for setting up and managing Azure Kubernetes clusters within the Rancher platform."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster
# custom:
#   id: CB_TFRAN_063
#   severity: LOW
package lib.terraform.CB_TFRAN_063

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
	aks_config_v2(block)
}

pass[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
    some innerblock in block.Blocks
	not innerblock.Type == "aks_config_v2"
}

aks_config_v2(block) {
    conflict_configs := [
        "aks_config",
        "eks_config",
        "eks_config_v2",
        "gke_config",
        "gke_config_v2",
        "oke_config",
		"k3s_config",
		"rke_config"
    ]
    some innerblock in block.Blocks
	innerblock.Type == "aks_config_v2"
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
		"message": "The Rancher2 Cluster has a valid AKS Configuration V2 provided, ensuring proper setup and management of Azure Kubernetes clusters.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Rancher2 Cluster does not have a valid AKS Configuration V2 provided. Please ensure that the required AKS configuration parameters are correctly specified to facilitate the setup and management of Azure Kubernetes clusters within the Rancher platform.",
		"snippet": block,
	}
}
