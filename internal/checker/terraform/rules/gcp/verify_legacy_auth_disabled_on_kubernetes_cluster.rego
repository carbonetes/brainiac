# METADATA
# title: "Verify Legacy Authorization is set to Disabled on Kubernetes Engine Clusters"
# description: "Disabling Legacy Authorization is beneficial for enhancing the security of your clusters."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_011
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_011
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
	block.Attributes.enable_legacy_abac == true
}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "Legacy Authorization is set to Disabled on Kubernetes Engine Clusters.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Legacy Authorization should be set to Disabled on Kubernetes Engine Clusters.",
                "snippet": block }
}