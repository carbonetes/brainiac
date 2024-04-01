# METADATA
# title: "Make certain that the security groups for Amazon EMR clusters are closed to the world"
# description: "Making guaranteed that the security groups for your Amazon EMR clusters are not accessible to the world is normally a wise security move. As outside parties won't be able to connect to them via the internet, this can aid in protecting your EMR clusters from unwanted access."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/figma/aws-4-49-0/latest/docs/resources/emr_cluster
# custom:
#   id: CB_TFAWS_329
#   severity: LOW
package lib.terraform.CB_TFAWS_329

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_emr_cluster"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_security_group" in resource.Labels
	some block in resource.Blocks
	block.Type == "ingress"
	"0.0.0.0/0" in block.Attributes.cidr_blocks
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
}

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "The security groups for Amazon EMR clusters are closed to the world.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "The security groups for Amazon EMR clusters must not be open to the world.",
		"snippet": block,
	}
}
