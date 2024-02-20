# METADATA
# title: "Verify Proper Configuration in Rancher Cloud Credentials for Google Kubernetes Engine"
# description: "This policy ensures that Rancher Cloud Credentials using the Google Kubernetes Engine driver are properly configured with valid and required attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cloud_credential
# custom:
#   id: CB_TFRAN_052
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_052
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
    not validate_gke(block)
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

validate_gke(block) {
    some innerblock in block.Blocks
    innerblock.Type == "googlekubernetesengine_credential_config"
    innerblock.Attributes.auth_encoded_json != ""
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Cloud Credential for Google Kubernetes Engine is properly configured.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Cloud Credential for Google Kubernetes Engine has invalid or missing attributes. Check and fix the configuration.",
        "snippet": block,
    }
}
