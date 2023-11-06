# METADATA
# title: "Verify Stackdriver Logging is set to Enabled on Kubernetes Engine Clusters"
# description: "This is crucial for monitoring cluster health, troubleshooting issues, maintaining security and compliance, optimizing resource usage, and performing data analysis to enhance your applications and services."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_001
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_001
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
   	block.Attributes.logging_service == "none"
}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "Stackdriver Logging is set to Enabled on Kubernetes Engine Clusters.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "Stackdriver Logging should be Enabled on Kubernetes Engine Clusters.",
                "snippet": block }
}