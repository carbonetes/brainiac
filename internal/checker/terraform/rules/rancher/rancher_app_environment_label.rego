# METADATA
# title: "Verify Rancher App Label Has Environment Set To Production"
# description: "This policy ensures that Rancher2 apps have a specific label for proper categorization and identification within the Rancher environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/app
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/app_v2
# custom:
#   id: CB_TFRAN_003
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_003

import future.keywords.in

isvalid(block) {
    supported_resources := ["rancher2_app", "rancher2_app_v2"]
    block.Type == "resource"
    some label in block.Labels
    label in supported_resources
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
    "environment" in object.keys(block.Attributes.labels)
    block.Attributes.labels.environment == "production"
    
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher app has the required label for proper categorization.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher app must have the specified label for proper categorization. Update the app configuration accordingly.",
        "snippet": block,
    }
}
