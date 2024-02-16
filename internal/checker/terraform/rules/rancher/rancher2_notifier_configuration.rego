# METADATA
# title: "Verify Rancher2 Notifier Configuration"
# description: "This policy aims to ensure that Rancher2 Notifier Configuration complies with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/4.0.0/docs/resources/notifier
# custom:
#   id: CB_TFRAN_091
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_091

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_notifier" in block.Labels
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
	block.Attributes.name != ""
    block.Attributes.cluster_id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Validation of Rancher2 Notifier Configuration successful, aligning with specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Notifier Configuration validation. Please review and adjust settings to meet specified parameters and standards.",
		"snippet": block,
	}
}
