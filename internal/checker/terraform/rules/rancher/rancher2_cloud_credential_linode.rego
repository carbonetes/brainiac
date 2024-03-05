# METADATA
# title: "Verify Proper Configuration in Rancher Cloud Credentials for Linode"
# description: "This policy ensures that the Rancher Cloud Credential is properly configured with valid and required attributes for Linode."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cloud_credential
# custom:
#   id: CB_TFRAN_053
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_053
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
    not validate_linode(block)
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

validate_linode(block) {
    some innerblock in block.Blocks
    innerblock.Type == "linode_credential_config"
    innerblock.Attributes.token != ""
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Cloud Credential for Linode is properly configured.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Cloud Credential for Linode has invalid or missing attributes. Check and fix the configuration.",
        "snippet": block,
    }
}