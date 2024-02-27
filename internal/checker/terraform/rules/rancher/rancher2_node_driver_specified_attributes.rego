# METADATA
# title: "Verify Rancher2 Node Driver Specified Attributes not Empty"
# description: "Policy to verify that specified attributes in Rancher2 Node Driver are not empty."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/node_driver
# custom:
#   id: CB_TFRAN_144
#   severity: LOW
package lib.terraform.CB_TFRAN_144

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_node_driver" in block.Labels
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
	block.Attributes.checksum == ""
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.description == ""
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.external_id == ""
}

fail[block] {
	some block in input
	isvalid(block)
	block.Attributes.whitelist_domains == []
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Node Driver specified attributes have been successfully validated, ensuring they are not empty.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Node Driver configuration. Ensure that specified attributes are provided and not empty.",
		"snippet": block,
	}
}
