# METADATA
# title: "Verify Datafusion Stackdriver Monitoring"
# description: "This policy ensures that Stackdriver monitoring is enabled for Datafusion, allowing for proactive detection and alerting on performance issues."
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/data_fusion_instance
# custom:
#   id: CB_TFGCP_119
#   severity: LOW
package lib.terraform.CB_TFGCP_119

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
	resource.Attributes.enable_stackdriver_monitoring == true
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Datafusion has Stackdriver monitoring enabled, providing proactive detection and alerting for performance issues.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Stackdriver monitoring is not enabled for Datafusion, which may result in a lack of proactive detection and alerting for potential performance issues. Enable Stackdriver monitoring for improved system oversight.",
		"snippet": block,
	}
}
