# METADATA
# title: "Verify Kubernetes RBAC users are managed with Google Groups for GKE"
# description: "This ensures that Role-Based Access Control (RBAC) users in a Kubernetes cluster are organized and controlled through Google Groups, enhancing security and simplifying user management in Google Kubernetes Engine (GKE)."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_051
#   severity: LOW
package lib.terraform.CB_TFGCP_051
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
   	inner_block.Type == "authenticator_groups_config"
	inner_block.Attributes.security_group != ""
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Kubernetes RBAC users are managed with Google Groups for GKE.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Kubernetes RBAC users should managed with Google Groups for GKE.",
                "snippet": block }
}