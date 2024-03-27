# METADATA
# title: "Verify that VPC flow logging is activated in every VPC"
# description: "We recommend that VPC Flow Logs are enabled for packet Rejects for VPCs to help detect anomalous traffic and insight during security workflows."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc.html
# custom:
#   id: CB_TFAWS_340
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_340

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_vpc"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getthelabelforawsvpc contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_vpc" in resource.Labels
	label := concat(".", resource.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_flow_log" in resource.Labels
	some label in getthelabelforawsvpc
	contains(resource.Attributes.vpc_id, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The VPC flow logging is activated in every VPC.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The VPC flow logging must be activated in every VPC.",
		"snippet": block,
	}
}
