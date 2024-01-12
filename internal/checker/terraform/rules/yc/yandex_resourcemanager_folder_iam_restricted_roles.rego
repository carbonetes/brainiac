# METADATA
# title: "Verify Elevated Access for Folder Members"
# description: "This policy ensures that members within a folder do not possess elevated access privileges, reducing the risk of unauthorized actions."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/resourcemanager_folder_iam_member
# custom:
#   id: CB_TFYC_023
#   severity: MEDIUM
package lib.terraform.CB_TFYC_023

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"yandex_resourcemanager_folder_iam_binding",
		"yandex_resourcemanager_folder_iam_member"
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
	invalid_roles := [
		"admin",
		"editor"
	]
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
		"message": " Folder members do not have elevated access, aligning with security best practices.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some folder members have elevated access, posing a security risk. Review and adjust their permissions to adhere to security policies.",
		"snippet": block,
	}
}
