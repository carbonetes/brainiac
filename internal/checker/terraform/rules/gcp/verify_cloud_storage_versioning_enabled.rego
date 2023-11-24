# METADATA
# title: "Verify Cloud storage has versioning enabled"
# description: "This ensures that versioning is activated for objects in Google Cloud Storage."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
# custom:
#   id: CB_TFGCP_075
#   severity: LOW
package lib.terraform.CB_TFGCP_075
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
   	inner_block.Type == "versioning"
	inner_block.Attributes.enabled == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Cloud storage has versioning enabled.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Cloud storage versioning should be enabled.",
                "snippet": block }
}