# METADATA
# title: "Verify the git config name is properly configured"
# description: "This policy ensures that the 'git_config_name' attribute within the 'ibm_app_config_snapshot' resource only contains alphanumeric characters, dots (.), hyphens (-), and underscores (_). Improper configuration can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_config_snapshot
# custom:
#   id: CB_TFIBM_105
#   severity: LOW
package lib.terraform.CB_TFIBM_105

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
    hasImproperGitConfigNameConfiguration(resource)
}

hasImproperGitConfigNameConfiguration(block) if {
    not regex.match(`^[a-zA-Z0-9\.\-_]+$`, block.Attributes.git_config_name)
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM App Config Snapshot resource has a properly configured 'git_config_name'. No action required.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM App Config Snapshot resource has an improperly configured 'git_config_name'. Please ensure the name only contains alphanumeric characters, dots (.), hyphens (-), and underscores (_).",
        "snippet": block,
    }
}
