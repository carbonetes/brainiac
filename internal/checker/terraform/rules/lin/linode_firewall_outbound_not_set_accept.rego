# METADATA
# title: "Verify that the Outbound Firewall Policy is configured to a value other than ACCEPT"
# description: "Confirm the Outbound Firewall Policy is configured to a value other than ACCEPT, promoting a security posture that restricts the outgoing traffic to enhance control and prevent potential vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/linode/linode/latest/docs/resources/firewall
# custom:
#   id: CB_TFLIN_005
#   severity: MEDIUM
package lib.terraform.CB_TFLIN_005

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"linode_firewall" in block.Labels
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
	block.Attributes.outbound_policy == "DROP"
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Outbound Firewall Policy is inputted as DROP.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Outbound Firewall Policy must be inputted as DROP.",
		"snippet": block,
	}
}
