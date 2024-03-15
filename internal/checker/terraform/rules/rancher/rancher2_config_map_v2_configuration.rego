# METADATA
# title: "Verify Rancher2 Config Map V2 Configuration"
# description: "Policy checks Rancher2 Config Map V2 configuration for compliance with set standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/config_map_v2
# custom:
#   id: CB_TFRAN_077
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_077

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_config_map_v2" in block.Labels
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
	block.Attributes.cluster_id != ""
	is_object(block.Attributes.data)
	count(block.Attributes.data) > 0
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
		"message": "Validation of Rancher2 Config Map V2 configuration is successful, adhering to the defined standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Config Map V2 configuration detected. Please review and adjust settings to meet compliance standards.",
		"snippet": block,
	}
}
