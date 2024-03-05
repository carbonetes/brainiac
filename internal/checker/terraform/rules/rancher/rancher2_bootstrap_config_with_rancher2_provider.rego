# METADATA
# title: "Verify Rancher Bootstrap Configuration connected with rancher2 provider"
# description: "This policy ensures that the Rancher Bootstrap configuration has the required provider properly set."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/bootstrap
# custom:
#   id: CB_TFRAN_033
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_033

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

fail[block] {
    some block in input
    isvalid(block)
    not is_rancher_attached == true
}

is_rancher_attached {
	some block in input
    block.Type == "provider"
	"rancher2" in block.Labels
    is_bootstrap_enabled(block)
}

is_bootstrap_enabled(block) {
	block.Attributes.bootstrap == true
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Bootstrap configuration has the correct provider settings.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Bootstrap configuration has incorrect provider settings. Check the documentation for proper configuration.",
        "snippet": block,
    }
}
