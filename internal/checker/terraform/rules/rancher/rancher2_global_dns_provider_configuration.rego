# METADATA
# title: "Verify Rancher2 Global DNS Provider Configuration"
# description: "Policy to validate Rancher2 Global DNS Provider Configuration for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/global_dns_provider
# custom:
#   id: CB_TFRAN_082
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_082

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_global_dns_provider" in block.Labels
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
	block.Attributes.root_domain != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "All Rancher2 Global DNS Provider configurations are valid and in compliance with specified standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Rancher2 Global DNS Provider configuration failed due to an empty or invalid root domain. Please ensure the root domain is provided and formatted correctly.",
		"snippet": block,
	}
}
