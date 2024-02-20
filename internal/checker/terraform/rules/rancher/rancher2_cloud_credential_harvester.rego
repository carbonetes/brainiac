# METADATA
# title: "Verify Proper Configuration in Rancher Cloud Credentials for Harvester"
# description: "This policy ensures that Rancher Cloud Credentials configured for Harvester are set up with the necessary and valid attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cloud_credential
# custom:
#   id: CB_TFRAN_054
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_054
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
    not validate_harvester(block)
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

validate_harvester(block) {
    some innerblock in block.Blocks
    innerblock.Type == "harvester_credential_config"
    innerblock.Attributes.cluster_id != "" 
    innerblock.Attributes.cluster_type != "" 
    innerblock.Attributes.kubeconfig_content != ""
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Cloud Credential for Harvester is properly configured.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Cloud Credential for Harvester has invalid or missing attributes. Check and fix the configuration.",
        "snippet": block,
    }
}