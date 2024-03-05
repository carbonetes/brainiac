# METADATA
# title: "Verify Rancher Bootstrap Configuration"
# description: "This policy ensures that the Rancher Bootstrap configuration has required attributes properly set."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/bootstrap
# custom:
#   id: CB_TFRAN_034
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_034

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_bootstrap" in block.Labels
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
    block.Attributes.password != ""
    block.Attributes.telemetry != ""
    block.Attributes.token_ttl != ""
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Bootstrap configuration is valid.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Bootstrap configuration has invalid attributes. Check the documentation for proper configuration.",
        "snippet": block,
    }
}