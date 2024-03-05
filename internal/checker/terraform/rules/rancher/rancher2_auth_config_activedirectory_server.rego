# METADATA
# title: "Verify Rancher Active Directory Configuration Servers"
# description: "This policy checks if the Rancher Active Directory configuration includes at least one server in the 'servers' attribute."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_activedirectory
# custom:
#   id: CB_TFRAN_008
#   severity: LOW
package lib.terraform.CB_TFRAN_008

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_auth_config_activedirectory" in block.Labels
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
	count(block.Attributes.servers) != 0
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Active Directory configuration includes at least one server in the 'servers' attribute.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Active Directory configuration is missing the 'servers' attribute or has an empty server list. Please provide at least one server for proper integration.",
		"snippet": block,
	}
}
