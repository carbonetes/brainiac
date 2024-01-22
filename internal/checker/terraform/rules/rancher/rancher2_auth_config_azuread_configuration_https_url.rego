# METADATA
# title: "Verify Rancher AzureAD Configuration Uses HTTPS URL"
# description: "This policy ensures that the Rancher AzureAD configuration has required settings for proper integration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_azuread
# custom:
#   id: CB_TFRAN_012
#   severity: LOW
package lib.terraform.CB_TFRAN_012

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_auth_config_azuread" in block.Labels
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
	startswith(block.Attributes.rancher_url, "https://")
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher AzureAD configuration uses HTTPS URL.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher AzureAD configuration does not use HTTPS URL in the rancher_url attribute. Update the configuration accordingly.",
        "snippet": block,
    }
}
