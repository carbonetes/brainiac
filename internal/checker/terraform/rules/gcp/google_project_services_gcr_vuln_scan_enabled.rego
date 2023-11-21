# METADATA
# title: "Verify that the Google Cloud Platform (GCP) Google Container Registry (GCR) Container Vulnerability Scanning is activated"
# description: "Confirm the activation of Google Cloud Platform's Google Container Registry (GCR) Container Vulnerability Scanning for enhanced container security. Assure that this security feature is enabled to proactively scan containers for vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/2.20.3/docs/resources/google_project_services
# custom:
#   id: CB_TFGCP_109
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_109

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_project_services" in block.Labels
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
	"containerscanning.googleapis.com" in block.Attributes.services
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "The Google Cloud Platform (GCP) Google Container Registry (GCR) Container Vulnerability Scanning is activated.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Google Cloud Platform (GCP) Google Container Registry (GCR) Container Vulnerability Scanning is deactivated.",
		"snippet": block,
	}
}
