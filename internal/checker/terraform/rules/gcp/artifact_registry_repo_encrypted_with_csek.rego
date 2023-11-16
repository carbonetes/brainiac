# METADATA
# title: "Verify Artifact Registry Repositories are encrypted with Customer Supplied Encryption Keys (CSEK)"
# description: "This ensures that data stored in Google Cloud Artifact Registry repositories is protected with encryption keys provided by the customer, enhancing data security and control."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository
# custom:
#   id: CB_TFGCP_086
#   severity: LOW
package lib.terraform.CB_TFGCP_086
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_artifact_registry_repository" in block.Labels
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
	block.Attributes.kms_key_name != ""
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Artifact Registry Repositories are encrypted with Customer Supplied Encryption Keys (CSEK).",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Artifact Registry Repositories should be encrypted with Customer Supplied Encryption Keys (CSEK).",
                "snippet": block }
}