# METADATA
# title: "Verify Non-Usage of Passport Accounts for Assignments"
# description: "This policy ensures that Passport accounts are not utilized for assignments. Instead, service accounts and federated accounts should be employed whenever possible to enhance security."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/resourcemanager_folder_iam_binding
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/resourcemanager_folder_iam_member
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/resourcemanager_cloud_iam_binding
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/resourcemanager_cloud_iam_member
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/organizationmanager_organization_iam_binding
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/organizationmanager_organization_iam_member
# custom:
#   id: CB_TFYC_024
#   severity: MEDIUM
package lib.terraform.CB_TFYC_024

import future.keywords.in

isvalid(block) {
	supported_resources := [
		"yandex_resourcemanager_folder_iam_binding",
		"yandex_resourcemanager_folder_iam_member",
		"yandex_resourcemanager_cloud_iam_binding",
		"yandex_resourcemanager_cloud_iam_member",
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

fail[resource] {
	some resource in input
	check_binding_label(resource)
	some member in resource.Attributes.members
	startswith(member, "userAccount:")
}

fail[resource] {
	some resource in input
	check_member_label(resource)
	member := resource.Attributes.member
	startswith(member, "userAccount:")
}

check_binding_label(block) {
	supported_resources := [
		"yandex_resourcemanager_folder_iam_binding",
		"yandex_resourcemanager_cloud_iam_binding",
		"yandex_organizationmanager_organization_iam_binding",
	]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

check_member_label(block) {
	supported_resources := [
		"yandex_resourcemanager_folder_iam_member",
		"yandex_resourcemanager_cloud_iam_member",
		"yandex_organizationmanager_organization_iam_member",
	]
	block.Type == "resource"
	some label in block.Labels
	label in supported_resources
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Assignments are configured without using Passport accounts, adhering to security guidelines.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Some assignments are configured with Passport accounts, which is not recommended. Modify the assignments to use service accounts or federated accounts for improved security.",
		"snippet": block,
	}
}
