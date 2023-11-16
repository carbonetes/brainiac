# METADATA
# title: "Verify the GKE Metadata Server is Enabled"
# description: "This ensures that the Google Kubernetes Engine (GKE) Metadata Server is active, allowing secure communication between pods and services, enhancing overall cluster security and functionality."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_060
#   severity: LOW
package lib.terraform.CB_TFGCP_060
import future.keywords.in

isvalid(block){
	supported_resources := ["google_container_node_pool", "google_container_cluster"]
	block.Type == "resource"
    some label in block.Labels
	label in supported_resources
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
	some first_block in block.Blocks
	first_block.Type == "node_config"
	some second_block in first_block.Blocks
	second_block.Type == "workload_metadata_config"
	second_block.Attributes.mode == "GKE_METADATA"
}

pass[block] {
    some block in input
	isvalid(block)
	some first_block in block.Blocks
	first_block.Type == "node_config"
	some second_block in first_block.Blocks
	second_block.Type == "workload_metadata_config"
	second_block.Attributes.node_metadata == "GKE_METADATA_SERVER"
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "GKE Metadata Server is Enabled.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "GKE Metadata Server should be Enabled.",
                "snippet": block }
}