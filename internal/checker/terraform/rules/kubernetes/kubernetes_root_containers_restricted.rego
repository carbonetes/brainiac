# METADATA
# title: "Disallow the admission of containers with root privileges"
# description: "Prevent the acceptance of containers with root privileges to enhance security and adhere to best practices in Kubernetes pod configurations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod_security_policy
# custom:
#   id: CB_TFK8S_007
#   severity: MEDIUM
package lib.terraform.CB_TFK8S_007

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
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	some run_as_user_block in inner_block.Blocks
	run_as_user_block.Type == "run_as_user"
	run_as_user_block.Attributes.rule == "MustRunAsNonRoot"
}

pass[block] {
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "spec"
	some run_as_user_block in inner_block.Blocks
	run_as_user_block.Type == "run_as_user"
	run_as_user_block.Attributes.rule == "MustRunAs"
	some range_block in run_as_user_block.Blocks
	range_block.Type == "range"
	to_number(range_block.Attributes.min) != 0
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The admission of containers with root privileges has been restricted.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The admission of containers with root privileges must be restricted.",
		"snippet": block,
	}
}
