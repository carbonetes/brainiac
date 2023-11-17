# METADATA
# title: "Verify Dataflow Jobs Privacy"
# description: "This check ensures that Google Cloud Dataflow jobs are configured to be private. Private Dataflow jobs restrict access to authorized users, minimizing the risk of unauthorized access to sensitive data and job configurations."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/spanner_database
# custom:
#   id: CB_TFGCP_098
#   severity: HIGH
package lib.terraform.CB_TFGCP_098

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_dataflow_job" in block.Labels
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
	resource.Attributes.ip_configuration == "WORKER_IP_PRIVATE"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Google Cloud Dataflow job is configured to be private, safeguarding data and job details from unauthorized access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Google Cloud Dataflow job is not configured as private, potentially exposing sensitive data and job configurations to unauthorized entities.",
		"snippet": block,
	}
}
