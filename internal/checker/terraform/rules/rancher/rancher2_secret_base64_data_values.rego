# METADATA
# title: "Verify Proper Base64 Data Values Configuration in Rancher2 Secret"
# description: "This policy ensures that the Rancher2 Secret configuration includes valid base64-encoded values for the data attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/secret
# custom:
#   id: CB_TFRAN_114
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_114

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_secret" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

is_valid_base64(s) {
	base64.encode(base64.decode(s)) == s
}

pass[block] {
	some block in input
	isvalid(block)
	is_valid_base64(block.Attributes.data.address)
	is_valid_base64(block.Attributes.data.username)
	is_valid_base64(block.Attributes.data.password)
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher2 Secret configuration includes valid base64-encoded values for the data attributes.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher2 Secret configuration has invalid or missing values for data. Ensure data values are properly base64-encoded.",
		"snippet": block,
	}
}
