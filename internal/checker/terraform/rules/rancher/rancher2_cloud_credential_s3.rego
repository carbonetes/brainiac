# METADATA
# title: "Verify Proper Configuration in Rancher Cloud Credentials for S3"
# description: "This policy ensures that Rancher Cloud Credential for S3 is configured with valid and required attributes."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/cloud_credential
# custom:
#   id: CB_TFRAN_056
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_056
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
    not validate_s3(block)
}

pass[block] {
    some block in input
    isvalid(block)
    not fail[block]
}

validate_s3(block) {
    some innerblock in block.Blocks
    innerblock.Type == "s3_credential_config"
    innerblock.Attributes.access_key != "" 
    innerblock.Attributes.secret_key != "" 
}

passed[result] {
    some block in pass
    result := {
        "message": "Rancher Cloud Credential for OpenStack is properly configured.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Rancher Cloud Credential for OpenStack has invalid or missing attributes. Check and fix the configuration.",
        "snippet": block,
    }
}