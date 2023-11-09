# METADATA
# title: "Verify Network Policy is enabled on Kubernetes Engine Clusters"
# description: "Enabling Network Policy on Kubernetes Engine Clusters enhances security by implementing fine-grained network controls."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_021
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_021
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
	inner_block.Type == "network_policy"
	inner_block.Attributes.enabled == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Network Policy is enabled on Kubernetes Engine Clusters.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Network Policy should be enabled on Kubernetes Engine Clusters.",
                "snippet": block }
}