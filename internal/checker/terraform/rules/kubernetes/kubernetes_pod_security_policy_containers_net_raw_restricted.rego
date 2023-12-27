# METADATA
# title: "Disallow containers that possess the NET_RAW capability"
# description: "Prevent the admission of containers equipped with the NET_RAW capability, enhancing security by restricting network-related capabilities within Kubernetes environments."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_010
#   severity: LOW
package lib.terraform.CB_TFK8S_010

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"kubernetes_pod_security_policy" in block.Labels
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
	expected_values := ["NET_RAW", "ALL"]
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	some capabilities in inner_block.Attributes.required_drop_capabilities
	capabilities in expected_values
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The admission of containers that possess the NET_RAW capability has been restricted.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The admission of containers that possess the NET_RAW capability must be restricted.",
		"snippet": block,
	}
}
