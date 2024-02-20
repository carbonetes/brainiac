# METADATA
# title: "Verify Rancher2 Cluster Driver Configuration"
# description: "Policy to validate the configuration of Rancher2 Cluster Drivers."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cluster_driver
# custom:
#   id: CB_TFRAN_072
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_072

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_cluster_driver" in block.Labels
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
	block.Attributes.active == true
	is_boolean(block.Attributes.builtin)
	block.Attributes.name != ""
	block.Attributes.url != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Policy successfully verifies the configuration of Rancher2 Cluster Drivers, ensuring adherence to specified requirements.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Policy indicates failure in verifying Rancher2 Cluster Driver configuration. Please review and address the issue to ensure compliance.",
		"snippet": block,
	}
}
