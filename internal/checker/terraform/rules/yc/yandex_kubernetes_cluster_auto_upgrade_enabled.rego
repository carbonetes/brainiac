# METADATA
# title: "Enable Kubernetes Cluster Auto-Upgrade"
# description: "This policy ensures that auto-upgrade is enabled for a Kubernetes cluster. Enabling auto-upgrade ensures that the cluster's control plane and nodes are automatically updated to the latest stable version, providing access to new features, bug fixes, and security patches."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/kubernetes_cluster
# custom:
#   id: CB_TFYC_007
#   severity: MEDIUM
package lib.terraform.CB_TFYC_007

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_kubernetes_cluster" in block.Labels
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
	some block in resource.Blocks
	block.Type == "master"
	some maintenance_policy in block.Blocks
	maintenance_policy.Type == "maintenance_policy"
	maintenance_policy.Attributes.auto_upgrade != false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Auto-upgrade is enabled for the Kubernetes cluster, ensuring timely updates to the latest stable version.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Auto-upgrade is not enabled for the Kubernetes cluster. It is recommended to enable auto-upgrade for consistent security and feature updates.",
		"snippet": block,
	}
}
