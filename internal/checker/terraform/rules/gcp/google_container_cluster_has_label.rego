# METADATA
# title: "Verify that Kubernetes Clusters Have Configured Labels"
# description: "This policy ensures that Kubernetes clusters have proper labels configured, enhancing resource management and organization."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
# custom:
#   id: CB_TFGCP_002
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_002
import future.keywords.in
import future.keywords.if

isvalid(resource) {
	resource.Type == "resource"
	"google_container_cluster" in resource.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
    "google_container_cluster" in block.Labels
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
    check_label(resource.Labels)
}

check_label(labels) := true if  {
    contains(lower(labels[0]), "google_container_cluster")
    label_count := count(labels)-1
    label_count > 0
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Kubernetes clusters are configured with appropriate labels.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Kubernetes clusters lack proper label configuration, impacting resource management and organization.",
		"snippet": block,
	}
}