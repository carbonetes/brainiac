# METADATA
# title: "Verify Rancher FreeIPA TLS Configuration"
# description: "This policy ensures that if TLS is enabled in the Rancher FreeIPA configuration, a valid CA certificate is provided."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_freeipa
# custom:
#   id: CB_TFRAN_016
#   severity: LOW
package lib.terraform.CB_TFRAN_016

import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_auth_config_freeipa" in block.Labels
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
    block.Attributes.certificate != ""
}

pass[block] {
    some block in input
    isvalid(block) 
    block.Attributes.tls in ["true", true]
}

fail[block] {
    some block in input
    isvalid(block)
    not pass[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher FreeIPA TLS configuration is valid.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher FreeIPA TLS is enabled, but a valid CA certificate is missing. Provide a valid CA certificate or disable TLS.",
        "snippet": block,
    }
}
