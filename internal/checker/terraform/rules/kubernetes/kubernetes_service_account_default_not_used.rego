# METADATA
# title: "Avoid Active Usage of Default Service Accounts"
# description: "This policy advises against actively using default service accounts. Default service accounts, if not properly managed, may have broad permissions, potentially leading to security vulnerabilities."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account
# custom:
#   id: CB_TFK8S_029
#   severity: LOW
package lib.terraform.CB_TFK8S_029

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"kubernetes_service_account",
		"kubernetes_service_account_v1",
	]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
    resource.Attributes.automount_service_account_token == false
    some block in resource.Blocks
    block.Type == "metadata"
    block.Attributes.name != "default"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "No active usage of default service accounts is identified, contributing to improved security posture.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Active usage of default service accounts is detected. It is recommended to avoid relying on default service accounts to enhance security.",
		"snippet": block,
	}
}
