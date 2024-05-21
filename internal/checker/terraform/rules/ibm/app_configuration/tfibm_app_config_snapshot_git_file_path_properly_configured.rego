# METADATA
# title: "Verify the git file path is properly configured"
# description: "This policy ensures that the 'git_file_path' attribute within the 'ibm_app_config_snapshot' resource ends with '.json'. The file path must contain the file name with a .json extension. Improper configuration can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_config_snapshot
# custom:
#   id: CB_TFIBM_096
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_096

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
    hasImproperGitFilePathConfiguration(resource)
}

hasImproperGitFilePathConfiguration(block) if {
    not regex.match(`.*\.json$`, block.Attributes.git_file_path)
}

passed contains result if {
    some block in pass
    result := {
        "message": "IBM App Config Snapshot resource has a properly configured 'git_file_path'. No action required.",
        "snippet": block,
    }
}

failed contains result if {
    some block in fail
    result := {
        "message": "IBM App Config Snapshot resource has an improperly configured 'git_file_path'. Please ensure the file path ends with '.json'.",
        "snippet": block,
    }
}