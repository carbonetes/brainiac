# METADATA
# title: "Verify Bucket does not log to itself"
# description: "Ensuring a Bucket does not log to itself prevents circular logging, maintaining the integrity and efficiency of log data storage and analysis."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
# custom:
#   id: CB_TFGCP_047
#   severity: LOW
package lib.terraform.CB_TFGCP_047
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
	inner_block.Attributes.log_bucket != block.Attributes.name
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Bucket is not log to itself",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Bucket should not log to itself.",
                "snippet": block }
}