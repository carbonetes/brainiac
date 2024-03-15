# METADATA
# title: "Verify Rancher2 Custom User Token Configuration"
# description: "Policy to validate Rancher2 Custom User Token configuration, ensuring adherence to specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/custom_user_token
# custom:
#   id: CB_TFRAN_078
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_078

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_custom_user_token" in block.Labels
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
	block.Attributes.username != ""
	block.Attributes.password != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Custom User Token configuration successfully validated, meeting all specified parameters and standards.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Failure in Rancher2 Custom User Token configuration detected. Username and password fields cannot be empty. Please provide valid values to meet configuration requirements.",
		"snippet": block,
	}
}
