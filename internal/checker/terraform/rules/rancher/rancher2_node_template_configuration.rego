# METADATA
# title: "Verify Rancher2 Node Template Configuration"
# description: "This policy ensures validation of Rancher2 Node Template Configuration, ensuring adherence to specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/4.0.0/docs/resources/node_template
# custom:
#   id: CB_TFRAN_090
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_090

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

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.name != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Successful validation confirms that Rancher2 Node Template Configuration complies with specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Node Template Configuration validation. Please review and adjust settings to meet specified parameters and standards.",
		"snippet": block,
	}
}
