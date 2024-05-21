# METADATA
# title: "Verify the identity confirm method is valid"
# description: "This policy validates that the 'identity_confirm_methods' attribute of the 'ibm_appid_idp_cloud_directory' resource is one of the allowed values. Misalignment can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_idp_cloud_directory
# custom:
#   id: CB_TFIBM_098
#   severity: LOW
package lib.terraform.CB_TFIBM_098

import rego.v1

isvalid(block) if {
    block.Type == "resource"
    "ibm_appid_application_cloud_directory" in block.Labels
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
    hasInvalidIdentityConfirmationMethod(resource)
}

hasInvalidIdentityConfirmationMethod(block) if {
	some method in block.Attributes.identity_confirm_methods
	method != "email"
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM AppID Cloud Directory resource has a valid identity confirm methods.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM AppID Cloud Directory resource has an invalid identity confirm methods.",
        "snippet": block,
    }
}
