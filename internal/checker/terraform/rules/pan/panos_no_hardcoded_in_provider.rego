# METADATA
# title: "Verify that PAN-OS credentials are not hardcoded in the provider configuration"
# description: "Confirm that PAN-OS credentials, such as API keys and passwords, are not hardcoded in the provider configuration. Failing to adhere to this guideline may expose sensitive information, leading to potential security risks."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/PaloAltoNetworks/panos/latest/docs
# custom:
#   id: CB_TFPAN_001
#   severity: MEDIUM
package lib.terraform.CB_TFPAN_001

import future.keywords.in

isvalid(block) {
	block.Type == "provider"
	"panos" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_api_key[label] {
	some block in input
	block.Type == "variable"
	"panos_api_key" in block.Labels
	label := concat(".", block.Labels)
}

label_for_password[label] {
	some block in input
	block.Type == "variable"
	"panos_password" in block.Labels
	label := concat(".", block.Labels)
}

api_key_password_connected {
	some block in input
	block.Type == "provider"
	"panos" in block.Labels
	some label_key in label_for_api_key
	contains(block.Attributes.api_key, label_key)
	some label_pass in label_for_password
	contains(block.Attributes.password, label_pass)
}

pass[block] {
	some block in input
	isvalid(block)
	api_key_password_connected
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "API keys and password are not hardcoded.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "API key and password must not be hardcoded.",
		"snippet": block,
	}
}
