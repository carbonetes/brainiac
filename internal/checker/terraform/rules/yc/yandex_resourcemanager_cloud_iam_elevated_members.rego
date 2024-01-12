# METADATA
# title: "Restrict Cloud Member Elevated Access"
# description: "This policy is designed to prevent cloud members from having elevated access privileges. Granting elevated access to cloud members can pose security risks, leading to potential unauthorized actions and compromising the overall system security."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/resourcemanager_cloud_iam_binding
# custom:
#   id: CB_TFYC_013
#   severity: MEDIUM
package lib.terraform.CB_TFYC_013

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"yandex_resourcemanager_cloud_iam_binding",
		"yandex_resourcemanager_cloud_iam_member",
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
	invalid_roles := ["admin", "editor"]
	not resource.Attributes.role in invalid_roles
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The cloud member does not have elevated access, adhering to security best practices.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The cloud member has elevated access privileges. It is crucial to restrict such access to minimize security vulnerabilities and unauthorized activities.",
		"snippet": block,
	}
}
