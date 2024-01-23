# METADATA
# title: "Verify Rancher GitHub Configuration is Disabled if Not Needed"
# description: "This policy checks if the Rancher GitHub configuration is disabled when not needed to reduce unnecessary exposure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_github
# custom:
#   id: CB_TFRAN_018
#   severity: LOW
package lib.terraform.CB_TFRAN_018

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_auth_config_github" in block.Labels
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
    block.Attributes.client_id != ""
    block.Attributes.client_secret != ""
}

pass[block] {
    some block in input
    isvalid(block)
	not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher GitHub configuration is appropriately disabled or has valid Client ID and Client Secret specified.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher GitHub configuration is enabled without valid Client ID or Client Secret specified. Disable the configuration or provide valid credentials for proper functionality.",
        "snippet": block,
    }
}