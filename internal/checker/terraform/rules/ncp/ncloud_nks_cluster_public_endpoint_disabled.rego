# METADATA
# title: "Verify that the public endpoint for the Naver Kubernetes Service is deactivated"
# description: "Guarantee the deactivation of the public endpoint for the Naver Kubernetes Service to enhance security and prevent unauthorized access."
# related_resources:
# - https://registry.terraform.io/providers/NaverCloudPlatform/ncloud/latest/docs/resources/nks_cluster
# custom:
#   id: CB_TFNCP_018
#   severity: MEDIUM
package lib.terraform.CB_TFNCP_018

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"ncloud_nks_cluster" in block.Labels
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
	block.Attributes.public_network == true
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The public endpoint for the Naver Kubernetes Service is inactive.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The public endpoint for the Naver Kubernetes Service must be inactive.",
		"snippet": block,
	}
}
