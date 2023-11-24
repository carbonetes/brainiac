# METADATA
# title: "Verify master authorized networks is set to enabled in GKE clusters"
# description: "This control ensures that only trusted entities within the specified IP ranges can interact with the cluster's control plane, reducing the risk of security breaches, unauthorized control plane access, and potential attacks on your GKE infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_040
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_040
import future.keywords.in
import future.keywords.if

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
	inner_block.Type == "master_authorized_networks_config"
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Master authorized networks is set to enabled in GKE clusters.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Master authorized networks should be set to enabled in GKE clusters",
                "snippet": block }
}