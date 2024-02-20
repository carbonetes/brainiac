# METADATA
# title: "Verify Rancher2 Cluster V2 Configuration"
# description: "Policy ensures Rancher2 Cluster V2 configuration is correctly set up according to defined standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_v2
# custom:
#   id: CB_TFRAN_076
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_076

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster_v2" in block.Labels
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
	block.Attributes.name != ""
    block.Attributes.kubernetes_version != ""
	block.Attributes.kubernetes_version in ["rke2/k3s-version", "rke2-version", "k3s-version"]
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Cluster V2 configuration successfully validated, meeting all defined standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Cluster V2 configuration detected. Either the 'kubernetes_version' or 'name' parameter is missing. Please ensure both parameters are included to meet configuration requirements.",
		"snippet": block,
	}
}
