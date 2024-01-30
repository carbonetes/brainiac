# METADATA
# title: "Verify Rancher Auth Configs SP Cert and SP Key Secure Configuration"
# description: "This policy ensures that sensitive information in Rancher configurations are properly handled and not exposed in plain text within Terraform configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/auth_config_ping
# custom:
#   id: CB_TFRAN_031
#   severity: HIGH
package lib.terraform.CB_TFRAN_031

import future.keywords.in

isvalid(block) {
    supported_resources := [
        "rancher2_auth_config_okta",
        "rancher2_auth_config_ping",
        "rancher2_auth_config_keycloak",
        "rancher2_auth_config_adfs"
    ]
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

fail[block] {
    some block in input
    isvalid(block) 
    block.Attributes.sp_cert != "" 
    contains(block.Attributes.sp_cert, "-----BEGIN CERTIFICATE-----") == false
}

fail[block] {
    some block in input
    isvalid(block) 
    block.Attributes.sp_key != "" 
    contains(block.Attributes.sp_key, "-----BEGIN PRIVATE KEY-----") == false
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Sensitive information in Rancher configurations are properly handled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Sensitive information in Rancher configurations are exposed in plain text. Update the configuration to securely handle sensitive information.",
        "snippet": block,
    }
}
