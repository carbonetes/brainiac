# METADATA
# title: "Disallow the inclusion of containers with elevated privileges"
# description: "Confirm that privileged containers are not allowed, preventing the inclusion of containers with elevated privileges."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_003
#   severity: HIGH
package lib.terraform.CB_TFK8S_003

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

fail[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	inner_block.Attributes.privileged == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Privileged containers have not been granted access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Privileged containers are not allowed.",
		"snippet": block,
	}
}
