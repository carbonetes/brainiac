# METADATA
# title: "Verify GCP Cloud Function HTTP trigger is secured"
# description: "This ensures that Cloud Function HTTP triggers are configured with proper security measures, preventing unauthorized access and enhancing the overall security of the application or service."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function
# custom:
#   id: CB_TFGCP_115
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_115

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_cloudfunctions_function" in block.Labels
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
	block.Attributes.https_trigger_security_level == "SECURE_ALWAYS"
}


fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "GCP Cloud Function HTTP trigger is secured.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "GCP Cloud Function HTTP trigger should be secured.",
		"snippet": block,
	}
}
