# METADATA
# title: "Verify Global Accelerator accelerator has flow logs enabled"
# description: "Flow logs capture detailed information about each network request, including source and destination IP addresses, ports, protocols, and other relevant metadata."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/globalaccelerator_accelerator
# custom:
#   id: CB_TFAWS_084
#   severity: LOW
package lib.terraform.CB_TFAWS_084

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_globalaccelerator_accelerator"
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
	block.Type == "attributes"
	block.Attributes.flow_logs_enabled == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_globalaccelerator_accelerator' 'flow_logs_enabled' attribute is set to true.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_globalaccelerator_accelerator' 'flow_logs_enabled' attribute should be set to true.",
		"snippet": block,
	}
}