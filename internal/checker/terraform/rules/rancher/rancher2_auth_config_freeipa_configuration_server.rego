# METADATA
# title: "Verify Rancher FreeIPA Servers Configuration"
# description: "This policy ensures that the Rancher FreeIPA configuration includes at least one server in the 'servers' attribute."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_freeipa
# custom:
#   id: CB_TFRAN_015
#   severity: LOW
package lib.terraform.CB_TFRAN_015

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_auth_config_freeipa" in block.Labels
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
    count(block.Attributes.servers) != 0
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher FreeIPA configuration includes at least one server in the 'servers' attribute.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher FreeIPA configuration is missing servers in the 'servers' attribute. Update the configuration accordingly.",
        "snippet": block,
    }
}
