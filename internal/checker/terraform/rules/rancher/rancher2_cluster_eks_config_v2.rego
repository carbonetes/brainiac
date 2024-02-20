# METADATA
# title: "Verify EKS Configuration V2 for Rancher2 Cluster"
# description: "This policy verifies that the Rancher2 Cluster has a valid EKS (Amazon Elastic Kubernetes Service) V2 configuration provided. The EKS V2 configuration is essential for defining and managing Kubernetes clusters on the Amazon Web Services platform within the Rancher environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster
# custom:
#   id: CB_TFRAN_065
#   severity: LOW
package lib.terraform.CB_TFRAN_065

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
	eks_config_v2(block)
}

pass[block] {
	some block in input
	isvalid(block)
	count(block.Blocks) == 1
    some innerblock in block.Blocks
	not innerblock.Type == "eks_config_v2"
}

eks_config_v2(block) {
    conflict_configs := [
        "aks_config",
        "aks_config_v2",
        "eks_config",
        "gke_config",
        "gke_config_v2",
        "oke_config",
		"k3s_config",
		"rke_config"
    ]
    some innerblock in block.Blocks
	innerblock.Type == "eks_config_v2"
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
		"message": "The Rancher2 Cluster has a valid EKS V2 configuration provided, ensuring the proper setup and management of Kubernetes clusters on the AWS platform within the Rancher environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Rancher2 Cluster does not have a valid EKS V2 configuration provided. Please ensure that all necessary EKS V2 configuration parameters are correctly specified to enable the proper setup and management of Kubernetes clusters on the AWS platform within the Rancher environment.",
		"snippet": block,
	}
}
