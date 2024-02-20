# METADATA
# title: "Verify Rancher Certificate Configuration"
# description: "This policy ensures that the Rancher Certificate configuration has required attributes properly set."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/certificate
# custom:
#   id: CB_TFRAN_044
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_044

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_certificate" in block.Labels
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
    block.Attributes.certs != ""
    block.Attributes.key != ""
    block.Attributes.project_id != ""
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Certificate configuration has all required attributes properly set.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Certificate configuration is missing one or more required attributes. Check and fix the configuration.",
        "snippet": block,
    }
}