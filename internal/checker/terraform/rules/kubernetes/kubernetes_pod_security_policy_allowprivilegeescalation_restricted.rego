# METADATA
# title: "Containers must refrain from executing with the allowPrivilegeEscalation setting"
# description: "Confirm that containers refrain from running with the allowPrivilegeEscalation setting, as it poses security risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_005
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_005

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
	inner_block.Attributes.allow_privilege_escalation == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Containers are not executing with the allowPrivilegeEscalation setting.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Containers must not execute with the allowPrivilegeEscalation setting.",
		"snippet": block,
	}
}
