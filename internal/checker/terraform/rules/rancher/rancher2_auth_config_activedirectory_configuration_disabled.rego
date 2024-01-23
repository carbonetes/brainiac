# METADATA
# title: "Verify Rancher Active Directory Configuration is Properly Disabled"
# description: "This policy checks if the Rancher Active Directory configuration is properly disabled by ensuring sensitive attributes are set to an empty string."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_activedirectory
# custom:
#   id: CB_TFRAN_021
#   severity: LOW
package lib.terraform.CB_TFRAN_021

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_auth_config_activedirectory" in block.Labels
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
    block.Attributes.service_account_username != ""
    block.Attributes.service_account_password != "" 
    block.Attributes.test_username != "" 
    block.Attributes.test_password != "" 
    block.Attributes.user_search_base != "" 
    block.Attributes.group_search_base != "" 
    count(block.Attributes.servers) != 0
}

pass[block] {
    some block in input
    isvalid(block)
	not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Active Directory configuration is properly disabled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Active Directory configuration is enabled or has non-empty sensitive attributes. Disable the configuration or set sensitive attributes to empty for proper security measures.",
        "snippet": block,
    }
}