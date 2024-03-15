# METADATA
# title: "Verify Rancher AzureAD Configuration"
# description: "This policy ensures that the Rancher AzureAD configuration has required settings for proper integration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_azuread
# custom:
#   id: CB_TFRAN_011
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_011

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
    block.Attributes.application_id != "" 
    block.Attributes.application_secret != "" 
    block.Attributes.auth_endpoint != "" 
    block.Attributes.graph_endpoint != "" 
    block.Attributes.rancher_url != ""
    block.Attributes.tenant_id != "" 
    block.Attributes.token_endpoint != ""
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher AzureAD configuration has the required settings.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher AzureAD configuration is missing required settings. Update the configuration accordingly.",
        "snippet": block,
    }
}