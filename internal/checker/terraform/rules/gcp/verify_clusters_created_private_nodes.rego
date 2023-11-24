# METADATA
# title: "Verify clusters are created with Private Nodes"
# description: "Creating clusters with Private Nodes enhances security by isolating node communication, reducing exposure to external threats."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_050
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_050
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
   	inner_block.Type == "private_cluster_config"
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Clusters are created with Private Nodes.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Clusters should be created with Private Nodes.",
                "snippet": block }
}