# METADATA
# title: "Verify Cloud build workers are private"
# description: "This ensures that Google Cloud Build workers operate in a private network environment, enhancing the security of build processes by restricting external access and potential exposure to sensitive information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudbuild_worker_pool
# custom:
#   id: CB_TFGCP_090
#   severity: LOW
package lib.terraform.CB_TFGCP_090
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_cloudbuild_worker_pool" in block.Labels
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
	inner_block.Type == "worker_config"
	inner_block.Attributes.no_external_ip == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Cloud build workers are private.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Cloud build workers should be set to private.",
                "snippet": block }
}