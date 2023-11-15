# METADATA
# title: "Verify Big Query Tables are encrypted with Customer Supplied Encryption Keys (CSEK)"
# description: "This ensures that data in BigQuery tables is encrypted using keys managed by the customer, providing an additional layer of control and security over the data stored in BigQuery."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_table
# custom:
#   id: CB_TFGCP_081
#   severity: LOW
package lib.terraform.CB_TFGCP_081
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_bigquery_table" in block.Labels
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
	inner_block.Type == "encryption_configuration"
	inner_block.Attributes.kms_key_name != ""
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Big Query Tables are encrypted with Customer Supplied Encryption Keys (CSEK).",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Big Query Tables should encrypt with Customer Supplied Encryption Keys (CSEK).",
                "snippet": block }
}