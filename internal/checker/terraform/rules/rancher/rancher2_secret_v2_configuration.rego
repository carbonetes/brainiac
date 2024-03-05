# METADATA
# title: "Verify Rancher2 Secret V2 Configuration"
# description: "Policy to verify Rancher2 Secret V2 Configuration for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/secret_v2
# custom:
#   id: CB_TFRAN_100
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_100

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_secret_v2" in block.Labels
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
	is_object(block.Attributes.data)
	count(block.Attributes.data) > 0
	block.Attributes.cluster_id != ""
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
		"message": "All Rancher2 Secret V2 Configurations are valid and comply with specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure detected in Rancher2 Secret V2 Configuration. The 'cluster_id,' 'data,' and 'name' fields are required. Ensure valid values are provided to meet configuration requirements.",
		"snippet": block,
	}
}
