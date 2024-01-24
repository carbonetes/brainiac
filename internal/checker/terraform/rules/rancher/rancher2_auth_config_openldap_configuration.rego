# METADATA
# title: "Verify Rancher OpenLDAP Configuration"
# description: "This policy ensures that the Rancher OpenLDAP configuration has required attributes properly set and is appropriately disabled when needed."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_openldap
# custom:
#   id: CB_TFRAN_026
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_026

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

pass[block] {
    some block in input
    isvalid(block) 
    block.Attributes.service_account_distinguished_name != "" 
    block.Attributes.service_account_password != "" 
    block.Attributes.test_username != "" 
    block.Attributes.test_password != "" 
    block.Attributes.user_search_base != ""
}

fail[block] {
    some block in input
    isvalid(block)
	not pass[block]
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