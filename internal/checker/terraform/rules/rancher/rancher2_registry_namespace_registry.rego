# METADATA
# title: "Verify Rancher2 Registry Namespaced Registry"
# description: "Policy to verify Rancher2 Registry Namespaced Registry, ensuring that the 'namespace_id' is specified for assignment to the namespaced registry."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/registry
# custom:
#   id: CB_TFRAN_180
#   severity: LOW
package lib.terraform.CB_TFRAN_180

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_registry" in block.Labels
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
    block.Attributes.namespace_id == ""
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Registry Namespaced Registry successfully validated with the 'namespace_id' assigned.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Registry Namespaced Registry. Please ensure that the 'namespace_id' is specified for assignment.",
		"snippet": block,
	}
}
