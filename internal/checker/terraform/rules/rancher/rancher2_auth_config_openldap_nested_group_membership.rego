# METADATA
# title: "Verify Rancher OpenLDAP Nested Group Membership Configuration"
# description: "This policy ensures that the Rancher OpenLDAP configuration has nested group membership correctly configured when enabled."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_openldap
# custom:
#   id: CB_TFRAN_028
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_028

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
    "nested_group_membership_enabled" in object.keys(block.Attributes)
    block.Attributes.nested_group_membership_enabled != false
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher OpenLDAP nested group membership is correctly configured.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher OpenLDAP nested group membership is not enabled. Enable nested group membership for better access control.",
        "snippet": block,
    }
}
