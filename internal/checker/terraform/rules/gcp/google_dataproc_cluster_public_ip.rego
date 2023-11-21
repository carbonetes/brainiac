# METADATA
# title: "Verify Dataproc Cluster Public IP Restriction"
# description: "This policy ensures that Dataproc Clusters are not configured with public IP addresses, reducing the potential exposure to external threats."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataproc_cluster
# custom:
#   id: CB_TFGCP_117
#   severity: HIGH
package lib.terraform.CB_TFGCP_117

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_dataproc_cluster" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "cluster_config"
	some innerblock in block.Blocks
	innerblock.Type == "gce_cluster_config"
	innerblock.Attributes.internal_ip_only == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Dataproc Clusters do not have public IPs, enhancing security by restricting external access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Dataproc Clusters have public IPs configured, posing a security risk. Update the configuration to remove public IP addresses for improved security.",
		"snippet": block,
	}
}
