# METADATA
# title: "Verify GKE Configuration for Rancher2 Cluster"
# description: "This policy ensures that the Rancher2 Cluster has a valid GKE (Google Kubernetes Engine) configuration provided. The GKE configuration is crucial for defining and managing Kubernetes clusters on the Google Cloud Platform within the Rancher environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster
# custom:
#   id: CB_TFRAN_066
#   severity: LOW
package lib.terraform.CB_TFRAN_066

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
	gke_config(block)
}

pass[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
    some innerblock in block.Blocks
	not innerblock.Type == "gke_config"
}

gke_config(block) {
    conflict_configs := [
        "aks_config",
        "aks_config_v2",
        "eks_config",
        "eks_config_v2",
        "gke_config_v2",
        "oke_config",
		"k3s_config",
		"rke_config"
    ]
    some innerblock in block.Blocks
	innerblock.Type == "gke_config"
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
		"message": "The Rancher2 Cluster has a valid GKE configuration provided, meeting the requirements for setting up and managing Kubernetes clusters on the Google Cloud Platform within the Rancher environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Rancher2 Cluster does not have a valid GKE configuration provided. Please ensure that the GKE configuration parameters are correctly specified to facilitate proper setup and management of Kubernetes clusters on the Google Cloud Platform within the Rancher environment.",
		"snippet": block,
	}
}
