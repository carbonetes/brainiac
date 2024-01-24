# METADATA
# title: "Verify Rancher OKTA Configuration is Properly Disabled"
# description: "This policy checks if the Rancher OKTA configuration is properly disabled by ensuring all sensitive attributes are set to empty when disabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_okta
# custom:
#   id: CB_TFRAN_025
#   severity: LOW
package lib.terraform.CB_TFRAN_025

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_auth_config_okta" in block.Labels
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
    block.Attributes.display_name_field != "" 
    block.Attributes.groups_field != "" 
    block.Attributes.idp_metadata_content != "" 
    block.Attributes.rancher_api_host != "" 
    block.Attributes.sp_cert != "" 
    block.Attributes.sp_key != "" 
    block.Attributes.uid_field != "" 
    block.Attributes.user_name_field != ""
}

pass[block] {
    some block in input
    isvalid(block)
	not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher OKTA configuration is properly disabled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher OKTA configuration is enabled or has non-empty sensitive attributes. Disable the configuration or set sensitive attributes to empty for proper security measures.",
        "snippet": block,
    }
}