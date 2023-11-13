# METADATA
# title: "Verify GKE basic auth is disabled"
# description: "By disabling basic authentication, you ensure that cluster access requires more secure methods like client certificates or IAM (Identity and Access Management) roles."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_039
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_039
import future.keywords.in
import future.keywords.if

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
   	some inner_block in block.Blocks
	inner_block.Type == "master_auth"
	check_credential(inner_block)
}
check_credential(block) := true if {
	block.Attributes.username != ""
} else := true if {
	block.Attributes.password != ""
}

pass[block] {
    some block in input
	isvalid(block)
    not fail[block]
}


passed[result] {
    some block in pass
	result := { "message": "GKE basic auth is disabled.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "GKE basic auth should be disabled",
                "snippet": block }
}