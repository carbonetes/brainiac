# METADATA
# title: "Confirm that firewall allows only specific and trusted inbound traffic"
# description: "Restrict firewall ingress to permit traffic exclusively on TCP port 22."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall
# custom:
#   id: CB_TFDIO_004
#   severity: MEDIUM
package lib.terraform.CB_TFDIO_004

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"digitalocean_firewall" in block.Labels
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
	restricted_values := ["0.0.0.0/0", "::/0"]
	some block in input
	isvalid(block)
	some inner_block in block.Blocks
	inner_block.Type == "inbound_rule"
	some restricted in inner_block.Attributes.source_addresses
	restricted in restricted_values
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The firewall permit only specific and trusted inbound traffic.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The firewall must permit only specific and trusted inbound traffic.",
		"snippet": block,
	}
}
