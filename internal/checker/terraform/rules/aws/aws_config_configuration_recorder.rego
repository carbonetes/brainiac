# METADATA
# title: "Make sure that AWS Config captures all potential resources"
# description: "This requirement mandates that AWS Config, a configuration management service, must be configured to comprehensively record and monitor all eligible resources within an AWS environment"
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_recorder.html
# custom:
#   id: CB_TFAWS_346
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_346

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_config_configuration_recorder"
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some inner in resource.Blocks
	inner.Type == "recording_group"
	inner.Attributes.include_global_resource_types == true
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

passed contains result if {
	some block in pass
	result := {
		"message": "Customer Managed Key (CMK) is used to encrypt the Comprehend Entity Recognizer's volume.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Customer Managed Key (CMK) must be used to encrypt the Comprehend Entity Recognizer's volume.",
		"snippet": block,
	}
}
