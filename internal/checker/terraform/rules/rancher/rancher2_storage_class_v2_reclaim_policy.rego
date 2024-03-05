# METADATA
# title: "Verify Rancher2 Storage Class v2 Reclaim Policy"
# description: "Policy to verify Rancher2 Storage Class v2 Reclaim Policy, ensuring that the reclaim policy for storageClass v2 is specified correctly."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/storage_class_v2
# custom:
#   id: CB_TFRAN_184
#   severity: LOW
package lib.terraform.CB_TFRAN_184

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_storage_class_v2" in block.Labels
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
    not reclaim_policy(block)
}

reclaim_policy(block){
	allowed_values := [
    	"Delete",
        "Recycle",
        "Retain"
    ]
    block.Attributes.reclaim_policy in allowed_values
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Storage Class v2 Reclaim Policy has been successfully validated with the specified reclaim policy.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Storage Class v2 Reclaim Policy configuration. Ensure that the reclaim policy is specified correctly, allowing values such as Delete, Recycle, and Retain.",
		"snippet": block,
	}
}
