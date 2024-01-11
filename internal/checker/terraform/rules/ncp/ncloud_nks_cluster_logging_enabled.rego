# METADATA
# title: "Verify that logging is activated for every log types within the control plane of Naver Kubernetes Service (NKS)"
# description: "Confirm that logging is activated for various log types across the control plane of Naver Kubernetes Service (NKS)."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/nks_cluster
# custom:
#   id: CB_TFNCP_021
#   severity: LOW
package lib.terraform.CB_TFNCP_021

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_nks_cluster" in block.Labels
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
	inner_block.Type == "log"
	some audit_block in inner_block.Blocks
	audit_block.Type == "audit"
	count(audit_block.Attributes) != 0
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The logging is active for every log types within the control plane of Naver Kubernetes Service (NKS).",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The logging must be active for every log types within the control plane of Naver Kubernetes Service (NKS).",
		"snippet": block,
	}
}
