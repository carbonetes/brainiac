# METADATA
# title: "Verify Rancher Active Directory Configuration"
# description: "This policy ensures that the Rancher Active Directory configuration has specific settings for proper integration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_activedirectory
# custom:
#   id: CB_TFRAN_006
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_006

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

pass[block] {
    some block in input
    isvalid(block) 
    block.Attributes.service_account_username != "" 
    block.Attributes.service_account_password != "" 
    block.Attributes.test_username != "" 
    block.Attributes.test_password != "" 
    block.Attributes.user_search_base != "" 
    block.Attributes.group_search_base != "" 
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

# Provide a message for a successful check
passed[result] {
    some block in pass
    result := {
        "message": "Rancher Active Directory configuration has the required settings.",
        "snippet": block,
    }
}

# Provide a message for a failed check
failed[result] {
    some block in fail
    result := {
        "message": "Rancher Active Directory configuration is missing required settings. Update the configuration accordingly.",
        "snippet": block,
    }
}
