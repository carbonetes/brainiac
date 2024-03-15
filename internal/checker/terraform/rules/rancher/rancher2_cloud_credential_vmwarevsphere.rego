# METADATA
# title: "Verify Proper Configuration in Rancher Cloud Credentials for VMWarevSphere"
# description: "This policy ensures that Rancher Cloud Credentials are configured with valid and required attributes for the VMWarevSphere driver."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cloud_credential
# custom:
#   id: CB_TFRAN_057
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_057
import future.keywords.in

isvalid(block) {
    block.Type == "resource"
    "rancher2_cloud_credential" in block.Labels
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
    not validate_vmwarevsphere(block)
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

validate_vmwarevsphere(block) {
    some innerblock in block.Blocks
    innerblock.Type == "vsphere_credential_config"
    innerblock.Attributes.password != "" 
    innerblock.Attributes.username != "" 
    innerblock.Attributes.vcenter != "" 
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Cloud Credential for VMWarevSphere is properly configured.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Cloud Credential for VMWarevSphere has invalid or missing attributes. Check and fix the configuration.",
        "snippet": block,
    }
}