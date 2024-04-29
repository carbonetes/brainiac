# METADATA
# title: "Verify the supported source type"
# description: "This policy checks if the 'source' attribute of the 'access_token_claim' block in the 'ibm_appid_token_config' resource is one of the vald source type in the following: 'saml', 'cloud_directory', 'facebook', 'google', 'appid_custom', 'ibmid', 'roles', 'attributes'. Misalignment can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_token_config
# custom:
#   id: CB_TFIBM_067
#   severity: LOW
package lib.terraform.CB_TFIBM_067

import rego.v1

isvalid(block) if {
    block.Type == "resource"
    "ibm_appid_token_config" in block.Labels
}

pass contains resource if {
    some resource in input
    isvalid(resource)
    not fail[resource]
}

fail contains resource if {
    some resource in input
    isvalid(resource)
    hasInvalidSourceType(resource)
}

hasInvalidSourceType(block) if {
    some type in block.Blocks
    type.Type = "access_token_claim"
    supported_types := ["saml", "cloud_directory", "facebook", "google", "appid_custom", "ibmid", "roles", "attributes"]
    not type.Attributes.source in supported_types
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM AppID Token Config resource has a valid source type.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM AppID Token Config resource has an invalid source type.",
        "snippet": block,
    }
}