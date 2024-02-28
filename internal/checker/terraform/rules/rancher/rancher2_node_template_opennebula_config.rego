# METADATA
# title: "Verify Opennebula Configuration for Node Template"
# description: "This policy ensures that Rancher2 Node Template using the Opennebula driver are properly configured with valid and required attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/node_template
# custom:
#   id: CB_TFRAN_154
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_154

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_node_template" in block.Labels
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
	not validate_opennebula(block)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

validate_opennebula(block) {
	some innerblock in block.Blocks
	innerblock.Type == "opennebula_config"
	innerblock.Attributes.password != ""
    innerblock.Attributes.user != ""
    innerblock.Attributes.xml_rpc_url != ""
}

passed[result] {
	some block in pass
	result := {
		"message": "Opennebula Configuration for Rancher2 Node Template is properly configured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Opennebula Configuration for Rancher2 Node Template has invalid or missing attributes. Check and fix the configuration.",
		"snippet": block,
	}
}
