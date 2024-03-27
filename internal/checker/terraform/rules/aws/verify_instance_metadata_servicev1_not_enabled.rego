# METADATA
# title: "Verify Instance Metadata Service Version 1 is not enabled"
# description: "Disabling Instance Metadata Service Version 1 helps to mitigate security risks and ensures that your EC2 instances are protected against unauthorized access and data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration.html
# custom:
#   id: CB_TFAWS_089
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_089

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_instance", "aws_launch_configuration", "aws_launch_template"]
	label in supportedresource
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
	some block in resource.Blocks
	block.Type == "metadata_options"
	block.Attributes.http_tokens == "required"
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "metadata_options"
	block.Attributes.http_endpoint = "disabled"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Instance Metadata Service Version 1 is not enabled",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Instance Metadata Service Version 1 should not be enabled",
		"snippet": block,
	}
}
