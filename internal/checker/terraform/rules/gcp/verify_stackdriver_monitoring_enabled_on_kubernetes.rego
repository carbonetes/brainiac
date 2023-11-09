# METADATA
# title: "Verify Stackdriver Monitoring is set to Enabled on Kubernetes Engine Clusters"
# description: "Enabling Stackdriver Monitoring provides critical insights into the performance and health of your clusters."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_015
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_015
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
	block.Attributes.monitoring_service != "none"
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Stackdriver Monitoring is set to Enabled on Kubernetes Engine Clusters.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Stackdriver Monitoring should set to Enabled on Kubernetes Engine Clusters.",
                "snippet": block }
}