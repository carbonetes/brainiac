# METADATA
# title: "Prevent Elevated Access for Organization Members"
# description: "This policy ensures that members within the organization do not possess elevated access, reducing the risk of unauthorized actions and potential security vulnerabilities."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/organizationmanager_organization_iam_binding
# custom:
#   id: CB_TFYC_021
#   severity: MEDIUM
package lib.terraform.CB_TFYC_021

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"yandex_organizationmanager_organization_iam_binding",
		"yandex_organizationmanager_organization_iam_member",
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
		"editor",
		"organization-manager.organizations.owner",
		"organization-manager.admin",
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
		"message": "Organization members do not have elevated access, contributing to a secure organizational environment.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some organization members have elevated access, presenting a potential security risk. It is recommended to review and limit access privileges to maintain a secure organizational structure.",
		"snippet": block,
	}
}
