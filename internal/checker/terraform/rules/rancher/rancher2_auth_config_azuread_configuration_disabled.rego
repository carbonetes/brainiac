# METADATA
# title: "Verify Rancher Azure AD Configuration is Disabled Properly"
# description: "This policy checks if the Rancher Azure AD configuration is disabled when not needed to reduce unnecessary exposure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_azuread
# custom:
#   id: CB_TFRAN_021
#   severity: LOW
package lib.terraform.CB_TFRAN_020

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

fail[block] {
    some block in input
    isvalid(block)
	block.Attributes.enabled == false
    block.Attributes.application_id != ""
    block.Attributes.application_secret != ""
}

pass[block] {
    some block in input
    isvalid(block)
	not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Azure AD configuration is appropriately disabled or has empty application ID and secret.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Azure AD configuration is enabled or has non-empty application ID and secret. Disable the configuration or set application ID and secret to empty for proper security measures.",
        "snippet": block,
    }
}