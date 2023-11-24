# METADATA
# title: "Verify GCP Kubernetes engine clusters have 'alpha cluster' feature disabled"
# description: "This ensures that the 'alpha cluster' feature is turned off in Google Cloud Platform's Kubernetes Engine clusters, promoting stability and security by avoiding the use of experimental or potentially unstable functionalities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_127
#   severity: LOW
package lib.terraform.CB_TFGCP_127
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
	block.Attributes.enable_kubernetes_alpha == true

}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "GCP Kubernetes engine clusters have 'alpha cluster' feature disabled.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "GCP Kubernetes engine clusters 'alpha cluster' feature should be disabled.",
                "snippet": block }
}