# METADATA
# title: "Verify Datafusion Stackdriver Logging"
# description: "This policy verifies that Stackdriver logging is enabled for Datafusion, ensuring comprehensive monitoring and logging capabilities for better visibility into system activities."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/data_fusion_instance
# custom:
#   id: CB_TFGCP_118
#   severity: LOW
package lib.terraform.CB_TFGCP_118

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"google_data_fusion_instance" in block.Labels
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
	resource.Attributes.enable_stackdriver_logging == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Datafusion has Stackdriver logging enabled, facilitating robust monitoring and logging.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Stackdriver logging is not enabled for Datafusion, which may hinder effective monitoring and troubleshooting. Enable Stackdriver logging for improved visibility.",
		"snippet": block,
	}
}
