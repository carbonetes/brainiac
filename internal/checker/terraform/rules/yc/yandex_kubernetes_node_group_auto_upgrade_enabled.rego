# METADATA
# title: "Enable Kubernetes Node Group Auto-Upgrade"
# description: "This policy ensures that auto-upgrade is enabled for a Kubernetes node group. Enabling auto-upgrade ensures that the nodes within the specified group are automatically updated to the latest stable version, providing access to new features, bug fixes, and security patches."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/kubernetes_node_group
# custom:
#   id: CB_TFYC_008
#   severity: MEDIUM
package lib.terraform.CB_TFYC_008

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_kubernetes_node_group" in block.Labels
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
	block.Type == "maintenance_policy"
	block.Attributes.auto_upgrade != false
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Auto-upgrade is enabled for the Kubernetes node group, ensuring timely updates to the latest stable version.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Auto-upgrade is not enabled for the Kubernetes node group. It is recommended to enable auto-upgrade for consistent security and feature updates.",
		"snippet": block,
	}
}
