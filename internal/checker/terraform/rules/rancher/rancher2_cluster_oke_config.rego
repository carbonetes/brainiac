# METADATA
# title: "Verify OKE Configuration for Rancher2 Cluster"
# description: "This policy verifies that the Rancher2 Cluster has a valid OKE (Oracle Kubernetes Engine) configuration provided. The OKE configuration is essential for defining and managing Kubernetes clusters on the Oracle Cloud Infrastructure within the Rancher environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster
# custom:
#   id: CB_TFRAN_068
#   severity: LOW
package lib.terraform.CB_TFRAN_068

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
	oke_config(block)
}

pass[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
    some innerblock in block.Blocks
	not innerblock.Type == "oke_config"
}

oke_config(block) {
    conflict_configs := [
        "aks_config",
        "aks_config_v2",
        "eks_config",
        "eks_config_v2",
        "gke_config",
        "gke_config_v2",
		"k3s_config",
		"rke_config"
    ]
    some innerblock in block.Blocks
	innerblock.Type == "oke_config"
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
		"message": "The Rancher2 Cluster has a valid OKE configuration provided, meeting the requirements for setting up and managing Kubernetes clusters on the Oracle Cloud Infrastructure within the Rancher environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Rancher2 Cluster does not have a valid OKE configuration provided. Please ensure that the OKE configuration parameters are correctly specified to facilitate proper setup and management of Kubernetes clusters on the Oracle Cloud Infrastructure within the Rancher environment.",
		"snippet": block,
	}
}
