# METADATA
# title: "Verify Rancher Active Directory Enabled"
# description: "This policy ensures that the Rancher Active Directory configuration has specific settings for proper integration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_activedirectory
# custom:
#   id: CB_TFRAN_007
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_007

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
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Active Directory Config Enabled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Active Directory configuration is explicitly disabled. Please make sure it is not set to false.",
        "snippet": block,
    }
}
