# METADATA
# title: "Verify Rancher2 Role Template Rules"
# description: "Policy to ensure that Rancher2 Role Template include rules."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/role_template
# custom:
#   id: CB_TFRAN_182
#   severity: LOW
package lib.terraform.CB_TFRAN_182

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_role_template" in block.Labels
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
	some innerblock in block.Blocks
	innerblock.Type == "rules"
	innerblock.Attributes.api_groups == []
}

fail[block] {
	some block in input
	isvalid(block)
	some innerblock in block.Blocks
	innerblock.Type == "rules"
	innerblock.Attributes.resources == []
}

fail[block] {
	some block in input
	isvalid(block)
	not policy_rule_verbs(block)
}

policy_rule_verbs(block) {
	verbs := [
		"bind",
		"create",
		"delete",
		"deletecollection",
		"escalate",
		"get",
		"impersonate",
		"list",
		"patch",
		"update",
		"use",
		"view",
		"watch",
		"own",
		"*",
	]
	some innerblock in block.Blocks
	innerblock.Type == "rules"
	some verb in innerblock.Attributes.verbs
	verb in verbs
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Role Template successfully validated with included rules.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Role Template configuration. Please ensure that rules are included.",
		"snippet": block,
	}
}
