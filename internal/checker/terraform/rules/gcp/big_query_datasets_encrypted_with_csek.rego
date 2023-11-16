# METADATA
# title: "Verify Big Query Datasets are encrypted with Customer Supplied Encryption Keys (CSEK)"
# description: "This ensures that data in BigQuery datasets is encrypted using keys managed by the customer, enhancing data security and control."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset
# custom:
#   id: CB_TFGCP_082
#   severity: LOW
package lib.terraform.CB_TFGCP_082
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_bigquery_dataset" in block.Labels
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
	inner_block.Type == "default_encryption_configuration"
	inner_block.Attributes.kms_key_name != ""
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Big Query Datasets are encrypted with Customer Supplied Encryption Keys (CSEK).",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Big Query Datasets should encrypt with Customer Supplied Encryption Keys (CSEK).",
                "snippet": block }
}