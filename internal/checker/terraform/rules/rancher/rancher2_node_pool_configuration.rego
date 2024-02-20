# METADATA
# title: "Verify Rancher2 Node Pool Configuration"
# description: "Policy to verify Rancher2 Node Pool Configuration for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/4.0.0/docs/resources/node_pool
# custom:
#   id: CB_TFRAN_089
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_089

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_node_pool" in block.Labels
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
    block.Attributes.cluster_id != ""
    block.Attributes.name != ""
    block.Attributes.hostname_prefix != ""
    block.Attributes.node_template_id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Node Pool Configuration successfully validated, meeting specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Node Pool Configuration. Please review and adjust settings to meet specified parameters and standards.",
		"snippet": block,
	}
}
