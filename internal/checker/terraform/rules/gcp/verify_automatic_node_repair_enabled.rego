# METADATA
# title: "Verify 'Automatic node repair' is enabled for Kubernetes Clusters"
# description: "Enabling automatic node repair helps maintain the reliability and availability of your Kubernetes workloads by automatically replacing nodes (virtual machines) that become unhealthy or experience failures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
# custom:
#   id: CB_TFGCP_017
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_017
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_container_node_pool" in block.Labels
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
	inner_block.Type == "management"
	inner_block.Attributes.auto_repair == true
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "'Automatic node repair' is enabled for Kubernetes Clusters.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "'Automatic node repair' should be enabled for Kubernetes Clusters.",
                "snippet": block }
}