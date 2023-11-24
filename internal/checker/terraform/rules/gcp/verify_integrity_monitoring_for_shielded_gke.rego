# METADATA
# title: "Verify Integrity Monitoring for Shielded GKE Nodes is Enabled"
# description: "This ensures that the integrity monitoring feature is activated for Shielded Nodes in Google Kubernetes Engine (GKE), providing continuous monitoring and verification of the runtime integrity of the nodes for enhanced security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_063
#   severity: LOW
package lib.terraform.CB_TFGCP_063
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

fail[block] {
    some block in input
	isvalid(block)
	some first_block in block.Blocks
	first_block.Type == "node_config"
	some second_block in first_block.Blocks
	second_block.Type == "shielded_instance_config"
	second_block.Attributes.enable_integrity_monitoring == false
}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "Integrity Monitoring for Shielded GKE Nodes is Enabled.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Integrity Monitoring for Shielded GKE Nodes should not be set to false.",
                "snippet": block }
}