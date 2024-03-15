# METADATA
# title: "Verify Rancher2 Machine Config V2 Configuration"
# description: "Policy to ensure Rancher2 Machine Config V2 configuration includes essential settings for seamless integration and compliance with standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/machine_config_v2
# custom:
#   id: CB_TFRAN_085
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_085

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_machine_config_v2" in block.Labels
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
	block.Attributes.generate_name != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Successful validation of Rancher2 Machine Config V2 configuration, aligning with integration requirements and compliance standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Machine Config V2 configuration detected. Please review and update settings to meet integration requirements and compliance standards.",
		"snippet": block,
	}
}
