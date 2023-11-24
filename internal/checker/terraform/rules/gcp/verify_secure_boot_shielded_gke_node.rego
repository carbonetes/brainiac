# METADATA
# title: "Verify Secure Boot for Shielded GKE Nodes is Enabled"
# description: "This enhances security by ensuring that GKE nodes run in a secure boot mode, providing protection against unauthorized or malicious kernel and bootloader modifications."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_059
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_059
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
	second_block.Type == "shielded_instance_config"
	second_block.Attributes.enable_secure_boot == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Secure Boot for Shielded GKE Nodes is Enabled.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Secure Boot for Shielded GKE Nodes should be Enabled.",
                "snippet": block }
}