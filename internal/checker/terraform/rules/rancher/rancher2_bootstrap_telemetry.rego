# METADATA
# title: "Verify Rancher Bootstrap Telemetry is Properly Disabled"
# description: "This policy ensures that the Rancher Bootstrap configuration has telemetry properly disabled when needed."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/bootstrap
# custom:
#   id: CB_TFRAN_035
#   severity: LOW
package lib.terraform.CB_TFRAN_035

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
    block.Attributes.telemetry == true
}

fail[block] {
    some block in input
    isvalid(block)
    not block.Attributes.telemetry == false
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Bootstrap telemetry is properly disabled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Bootstrap telemetry is enabled. Disable telemetry for proper security measures.",
        "snippet": block,
    }
}