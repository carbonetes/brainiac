# METADATA
# title: "Verify API Gateway has X-Ray Tracing enabled"
# description: "It allows you to gain insights into the performance and behavior of your API Gateway endpoints, identify and troubleshoot latency issues, understand the flow of requests through your API, and diagnose errors and exceptions. X-Ray tracing provides valuable visibility into the execution of your API Gateway, helping you optimize performance, identify bottlenecks, and ensure a smooth and efficient API experience for your users."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_stage
# custom:
#   id: CB_TFAWS_081
#   severity: LOW
package lib.terraform.CB_TFAWS_081

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_api_gateway_stage"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Attributes.xray_tracing_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_api_gateway_stage' 'xray_tracing_enabled' is enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_api_gateway_stage' 'xray_tracing_enabled' should be enabled.",
		"snippet": block,
	}
}