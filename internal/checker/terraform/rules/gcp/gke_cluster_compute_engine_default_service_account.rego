# METADATA
# title: "Verify GKE clusters are not running using the Compute Engine default service account"
# description: "This ensures that Google Kubernetes Engine (GKE) clusters are configured with specific, non-default service accounts, reducing the risk of unintended access and potential security vulnerabilities associated with default service account permissions."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_default_service_accounts
# custom:
#   id: CB_TFGCP_102
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_102

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_project_default_service_accounts" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

service_account_label[label] {
	some block in input
	block.Type == "resource"
	"google_project_default_service_accounts" in block.Labels
	label := concat(".", block.Labels)
}

fail[block] {
	some block in input
	block.Type == "resource"
	"google_container_node_pool" in block.Labels
	some label in service_account_label
	contains(block.Attributes.service_account, label)
}

fail[block] {
	some block in input
	block.Type == "resource"
	"google_container_cluster" in block.Labels
	some inner_block in block.Blocks
	inner_block.Type == "node_config"
	some label in service_account_label
	contains(inner_block.Attributes.service_account, label)
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "GKE clusters are not running using the Compute Engine default service account.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "GKE clusters should not running using the Compute Engine default service account.",
		"snippet": block,
	}
}
