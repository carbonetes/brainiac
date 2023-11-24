# METADATA
# title: "Verify Big Table Instances are encrypted with Customer Supplied Encryption Keys (CSEK)"
# description: "This ensures that data in Google Cloud Bigtable instances is protected with encryption keys provided by the customer, offering enhanced security and control over sensitive information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigtable_instance
# custom:
#   id: CB_TFGCP_087
#   severity: LOW
package lib.terraform.CB_TFGCP_087
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_bigtable_instance" in block.Labels
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
	some inner_block in block.Blocks
	inner_block.Type == "cluster"
	inner_block.Attributes.kms_key_name != ""
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