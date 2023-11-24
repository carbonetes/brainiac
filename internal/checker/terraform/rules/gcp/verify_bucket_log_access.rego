# METADATA
# title: "Verify Bucket log access"
# description: "Verifying Bucket Log Access ensures comprehensive auditing and traceability of object storage activities, fostering accountability and security within the cloud environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
# custom:
#   id: CB_TFGCP_046
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_046
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_storage_bucket" in block.Labels
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
   	inner_block.Type == "logging"
	inner_block.Attributes.log_bucket != ""
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Bucket have log access.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Bucket should have log access.",
                "snippet": block }
}