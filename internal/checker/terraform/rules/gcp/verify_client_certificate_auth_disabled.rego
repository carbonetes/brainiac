# METADATA
# title: "Verify client certificate authentication to Kubernetes Engine Clusters is disabled"
# description: "By disabling client certificate authentication, you ensure that users or systems connecting to the cluster do not need to present a client certificate for authentication."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_023
#   severity: LOW
package lib.terraform.CB_TFGCP_023
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
   	some first_block in block.Blocks
	first_block.Type == "master_auth"
	some second_block in first_block.Blocks
	second_block.Type == "client_certificate_config"
	second_block.Attributes.issue_client_certificate == false
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "Client certificate authentication to Kubernetes Engine Clusters is disabled.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "client certificate authentication to Kubernetes Engine Clusters should be disabled.",
                "snippet": block }
}