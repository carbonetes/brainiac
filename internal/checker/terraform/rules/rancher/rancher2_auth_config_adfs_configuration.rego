# METADATA
# title: "Verify Rancher ADFS Configuration"
# description: "This policy ensures that the Rancher ADFS configuration has required settings for proper integration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_adfs
# custom:
#   id: CB_TFRAN_009
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_009

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_auth_config_adfs" in block.Labels
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
	block.Attributes.display_name_field != ""
	block.Attributes.groups_field != ""
	block.Attributes.idp_metadata_content != ""
	block.Attributes.rancher_api_host != ""
	block.Attributes.sp_cert != ""
	block.Attributes.sp_key != ""
	block.Attributes.uid_field != ""
	block.Attributes.user_name_field != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher ADFS configuration has the required settings.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher ADFS configuration is missing required settings. Update the configuration accordingly.",
		"snippet": block,
	}
}