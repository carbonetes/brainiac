# METADATA
# title: "Verify the action type is supported"
# description: "This policy checks if the IBM AppID Action URL resource has a supported action type. The supported action types are 'on_user_verified' and 'on_reset_password'. If the action type is not supported, it can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_action_url
# custom:
#   id: CB_TFIBM_097
#   severity: LOW
package lib.terraform.CB_TFIBM_097

import rego.v1

isvalid(block) if {
    block.Type == "resource"
    "ibm_appid_action_url" in block.Labels
}

resource contains resource if {
    some block in pass
    resource := concat(".", block.Labels)
}

resource contains resource if {
    some block in fail
    resource := concat(".", block.Labels)
}

pass contains resource if {
    some resource in input
    isvalid(resource)
    not fail[resource]
}

fail contains resource if {
    some resource in input
    isvalid(resource)
    hasNotSupportedType(resource)
}

hasNotSupportedType(block) if {
    supported_types := ["on_user_verified", "on_reset_password"]
    not block.Attributes.action in supported_types
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM AppID Action URL resource has a supported action type. No action required.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM AppID Action URL resource has an unsupported action type. Please update the action type.",
        "snippet": block,
    }
}