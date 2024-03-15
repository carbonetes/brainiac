# METADATA
# title: "Verify Supported Drivers in Rancher Cloud Credential"
# description: "This policy ensures that the Rancher Cloud Credential uses a supported driver."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cloud_credential
# custom:
#   id: CB_TFRAN_048
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_048

import future.keywords.in

is_valid(block) {
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
    is_valid(block)
    drivers := [
    	"amazonec2_credential_config", 
        "azure_credential_config", 
        "digitalocean_credential_config", 
        "googlekubernetesengine_credential_config", 
        "linode_credential_config", 
        "openstack_credential_config", 
        "s3_credential_config", 
        "vmwarevsphere_credential_config"
    ]
    some innerblock in block.Blocks
    not innerblock.Type in drivers
}

pass[block] {
    some block in input
    is_valid(block)
    not fail[block]
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Cloud Credential uses a supported driver.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Ensure the Rancher Cloud Credential uses a supported driver.",
        "snippet": block,
    }
}
