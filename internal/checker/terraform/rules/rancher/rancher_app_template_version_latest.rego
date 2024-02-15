# METADATA
# title: "Verify Rancher App Template Version"
# description: "This policy ensures that the Rancher2 app is deployed using a specific template version for consistency and compatibility."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/app
# custom:
#   id: CB_TFRAN_002
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_002

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_app" in block.Labels
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
    block.Attributes.template_version != "latest"
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher app is using the correct template version.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher app must use the specified template version. Update the template version for consistency.",
        "snippet": block,
    }
}
