# METADATA
# title: "Verify Proper Configuration in Rancher Cloud Credentials for AmazonEC2"
# description: "This policy ensures that the required attributes for the AmazonEC2 driver are properly configured in Rancher Cloud Credentials."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cloud_credential
# custom:
#   id: CB_TFRAN_050
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_050
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
    not validate_azure(block)
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

validate_azure(block) {
    some innerblock in block.Blocks
    innerblock.Type == "azure_credential_config"
    innerblock.Attributes.client_id != "" 
    innerblock.Attributes.client_secret != "" 
    innerblock.Attributes.subscription_id != ""
}

passed[result] {
    some block in pass
    result := {
        "message": "Proper configuration for AmazonEC2 in Rancher Cloud Credentials is verified.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Ensure proper configuration for AmazonEC2 in Rancher Cloud Credentials.",
        "snippet": block,
    }
}
