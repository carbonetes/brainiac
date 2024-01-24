# METADATA
# title: "Verify Rancher OKTA Configuration"
# description: "This policy ensures that the Rancher OKTA configuration includes valid settings when enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_okta
# custom:
#   id: CB_TFRAN_024
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_024

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
        "message": "Rancher OKTA configuration is appropriately disabled or has valid settings when enabled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher OKTA configuration is enabled but missing valid settings. Disable the configuration or provide valid settings for proper functionality.",
        "snippet": block,
    }
}