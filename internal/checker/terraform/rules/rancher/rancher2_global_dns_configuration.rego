# METADATA
# title: "Verify Rancher2 Global DNS Configuration"
# description: "Policy to verify Rancher2 Global DNS Configuration for compliance with defined parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/global_dns
# custom:
#   id: CB_TFRAN_081
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_081

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_global_dns" in block.Labels
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
	block.Attributes.fqdn != ""
	block.Attributes.provider_id != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "All Rancher2 Global DNS configurations are valid and in compliance with specified standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some Rancher2 Global DNS configurations are invalid.  Please review and update configurations to ensure compliance with specified standards.",
		"snippet": block,
	}
}
