# METADATA
# title: "Verify K3S Configuration for Rancher2 Cluster"
# description: "This policy ensures that the Rancher2 Cluster has a valid K3S (Kubernetes distribution) configuration provided. The K3S configuration is crucial for defining and managing the Kubernetes cluster's setup and behavior."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster
# custom:
#   id: CB_TFRAN_061
#   severity: LOW
package lib.terraform.CB_TFRAN_061

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
	k3s_config(block)
}

pass[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
    some innerblock in block.Blocks
	not innerblock.Type == "k3s_config"
}

k3s_config(block) {
    conflict_configs := [
        "aks_config",
        "aks_config_v2",
        "eks_config",
        "eks_config_v2",
        "gke_config",
        "gke_config_v2",
        "oke_config",
		"rke_config"
    ]
    some innerblock in block.Blocks
	innerblock.Type == "k3s_config"
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
		"message": "The Rancher2 Cluster has a valid K3S configuration provided, meeting the requirements for Kubernetes cluster setup and management.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Rancher2 Cluster does not have a valid K3S configuration provided. Please ensure that the K3S configuration is correctly specified to facilitate proper setup and management of the Kubernetes cluster.",
		"snippet": block,
	}
}
