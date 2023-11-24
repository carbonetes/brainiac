# METADATA
# title: "Verify Shielded GKE Nodes are Enabled"
# description: "This ensures that Shielded Nodes, which offer additional security features such as secure boot and runtime integrity checking, are activated in Google Kubernetes Engine (GKE) for enhanced protection of containerized workloads."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_062
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_062
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
	block.Attributes.enable_shielded_nodes == false
}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "Shielded GKE Nodes are Enabled.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Shielded GKE Nodes should be Enabled.",
                "snippet": block }
}