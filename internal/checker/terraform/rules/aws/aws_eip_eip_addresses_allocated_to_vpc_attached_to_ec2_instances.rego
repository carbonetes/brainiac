# METADATA
# title: "An EIP addresses of a VPC must be connected to EC2 instances"
# description: "In order to build NAT gateways in your AWS account, verify that an Elastic IP (EIP) has been assigned for each one. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip
# custom:
#   id: CB_TFAWS_352
#   severity: LOW
package lib.terraform.CB_TFAWS_352

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_eip"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

getthelabelforawsinstance contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_instance" in resource.Labels
	label := concat(".", resource.Labels)
}

is_valid_attachments if {
	some resource in input
	resource.Type == "resource"
	"aws_eip" in resource.Labels
	resource.Attributes.vpc == true
	some label in getthelabelforawsinstance
	contains(resource.Attributes.instance, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_attachments
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "An EIP addresses of a VPC is connected to EC2 instances.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "An EIP addresses of a VPC must be connected to EC2 instances.",
		"snippet": block,
	}
}
