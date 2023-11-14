# METADATA
# title: "Verify the GKE Release Channel is set"
# description: "This ensures that a specific release channel is configured for Google Kubernetes Engine (GKE), providing control over updates and ensuring consistency in the Kubernetes environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_061
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_061
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_container_cluster" in block.Labels
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
	inner_block.Type == "release_channel"
	inner_block.Attributes.channel != ""
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "GKE Release Channel is set.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "GKE Release Channel should be set.",
                "snippet": block }
}