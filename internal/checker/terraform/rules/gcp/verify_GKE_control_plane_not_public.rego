# METADATA
# title: "Verify GKE Control Plane is not public"
# description: "When the control plane is not exposed to the public internet, it minimizes the attack surface and reduces the risk of unauthorized access or security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_037
#   severity: LOW
package lib.terraform.CB_TFGCP_037
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

fail[block] {
    some block in input
	isvalid(block)
   	some first_block in block.Blocks
	first_block.Type == "master_authorized_networks_config"
	some second_block in first_block.Blocks
	second_block.Attributes.cidr_block == "0.0.0.0/0"
}


pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "GKE Control Plane is not public.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "GKE Control Plane shoul not be public",
                "snippet": block }
}