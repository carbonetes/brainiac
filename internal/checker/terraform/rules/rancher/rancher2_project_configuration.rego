# METADATA
# title: "Verify Rancher2 Project Configuration"
# description: "Policy to verify Rancher2 Project Configuration for compliance with specified parameters and standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/project
# custom:
#   id: CB_TFRAN_093
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_093

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_project" in block.Labels
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
    block.Attributes.name != ""
    block.Attributes.cluster_id != ""
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher2 Project Configuration successfully validated, meeting specified parameters and standards.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Failure detected in Rancher2 Project Configuration. The 'name' and 'cluster_id' fields are required. Please provide valid values to meet configuration requirements.",
        "snippet": block,
    }
}