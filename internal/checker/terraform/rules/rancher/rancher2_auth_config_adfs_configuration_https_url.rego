# METADATA
# title: "Restrict ADFS Configuration URLs to HTTPS"
# description: "This policy ensures that the Rancher ADFS configuration URLs are using HTTPS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_adfs
# custom:
#   id: CB_TFRAN_010
#   severity: LOW
package lib.terraform.CB_TFRAN_010

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
	startswith(block.Attributes.rancher_api_host, "https://")
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Rancher ADFS configuration rancher_api_host uses HTTPS.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Rancher ADFS configuration rancher_api_host must use HTTPS. Update the configuration accordingly.",
		"snippet": block,
	}
}
