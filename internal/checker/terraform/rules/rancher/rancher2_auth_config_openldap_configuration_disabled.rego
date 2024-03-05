# METADATA
# title: "Verify Rancher OpenLDAP Configuration is Properly Disabled"
# description: "This policy ensures that the Rancher OpenLDAP configuration is properly disabled when needed, with sensitive attributes set to empty."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_openldap
# custom:
#   id: CB_TFRAN_029
#   severity: LOW
package lib.terraform.CB_TFRAN_029

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_auth_config_openldap" in block.Labels
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
    count(block.Attributes.servers) != 0
    block.Attributes.service_account_distinguished_name != "" 
    block.Attributes.service_account_password != "" 
    block.Attributes.test_password != ""
    block.Attributes.user_search_base != ""
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher OpenLDAP configuration is properly disabled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher OpenLDAP configuration is enabled or has non-empty sensitive attributes. Disable the configuration or set sensitive attributes to empty for proper security measures.",
        "snippet": block,
    }
}
