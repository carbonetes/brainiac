# METADATA
# title: "Verify Rancher FreeIPA Configuration is Disabled if Not Needed"
# description: "This policy checks if the Rancher FreeIPA configuration is disabled when not needed to reduce unnecessary exposure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_freeipa
# custom:
#   id: CB_TFRAN_019
#   severity: LOW
package lib.terraform.CB_TFRAN_019

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

fail[block] {
    some block in input
    isvalid(block)
	block.Attributes.enabled == false
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
        "message": "Rancher FreeIPA configuration is appropriately disabled or has at least one server specified.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher FreeIPA configuration is enabled without any servers specified. Disable the configuration or provide at least one server for proper functionality.",
        "snippet": block,
    }
}