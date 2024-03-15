# METADATA
# title: "Verify Rancher2 Namespace Container Resource Limit"
# description: "Policy to ensure that Rancher2 Namespace includes Container Resource Limit."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/namespace
# custom:
#   id: CB_TFRAN_141
#   severity: LOW
package lib.terraform.CB_TFRAN_141

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_namespace" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type == "container_resource_limit"
	innerblock.Attributes.limits_cpu == ""
	innerblock.Attributes.limits_memory == ""
	innerblock.Attributes.requests_cpu == ""
	innerblock.Attributes.requests_memory == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Namespace container resource limit have been successfully validated and are included as specified.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Namespace configuration. Ensure that 'container_resource_limit' are provided and included as specified.",
		"snippet": block,
	}
}
