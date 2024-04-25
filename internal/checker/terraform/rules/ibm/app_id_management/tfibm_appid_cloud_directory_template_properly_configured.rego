# METADATA
# title: "Verify the template name is properly configured"
# description: "This policy validates that the 'template_name' attribute of the 'ibm_appid_cloud_directory_template' resource is one of the allowed values. Misalignment can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/appid_cloud_directory_template
# custom:
#   id: CB_TFIBM_040
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_040

import rego.v1

isvalid(block) if {
    block.Type == "resource"
    "ibm_appid_cloud_directory_template" in block.Labels
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
    hasInvalidTemplateName(resource)
}

hasInvalidTemplateName(block) if {
	valid_types := ["USER_VERIFICATION", "WELCOME", "PASSWORD_CHANGED", "RESET_PASSWORD", "MFA_VERIFICATION"]
    not block.Attributes.template_name in valid_types
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM AppID Cloud Directory Template resource has a valid template name.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM AppID Cloud Directory Template resource has an invalid template name.",
        "snippet": block,
    }
}