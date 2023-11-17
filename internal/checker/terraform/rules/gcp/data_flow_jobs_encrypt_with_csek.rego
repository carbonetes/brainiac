# METADATA
# title: "Verify data flow jobs are encrypted with Customer Supplied Encryption Keys (CSEK)"
# description: "This ensures that data flow jobs utilize customer-supplied encryption keys, providing an additional layer of control and security over the encryption process for sensitive data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataflow_job
# custom:
#   id: CB_TFGCP_094
#   severity: LOW
package lib.terraform.CB_TFGCP_094
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_dataflow_job" in block.Labels
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
	result := { "message": "Data flow jobs are encrypted with Customer Supplied Encryption Keys (CSEK).",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Data flow jobs should encrypt with Customer Supplied Encryption Keys (CSEK).",
                "snippet": block }
}