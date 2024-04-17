# METADATA
# title: "Verify the git token is not exposed"
# description: "This policy ensures that the 'git_token' attribute within the 'git_config' resource of IBM App Config Snapshot remains concealed. Exposing the 'git_token' can lead to significant security risks, including unauthorized access and sensitive data exposure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_config_snapshot
# custom:
#   id: CB_TFIBM_045
#   severity: HIGH
package lib.terraform.CB_TFIBM_045

import rego.v1

isvalid(block) if {
    block.Type == "resource"
    "ibm_app_config_snapshot" in block.Labels
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
    hasExposedSensitiveAttributes(resource)
}

hasExposedSensitiveAttributes(block) if {
    regex.match(`^(gh[ps]_[a-zA-Z0-9]{36}|github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59})$`, block.Attributes.git_token)
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM App Config Snapshot git config resource complies with security standards by not exposing the 'git_token'. This mitigates potential security risks and reduces the likelihood of unauthorized access.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "TIBM App Config Snapshot git config resource exposes the 'git_token', posing significant security risks such as unauthorized access and sensitive data exposure.",
        "snippet": block,
    }
}
