# METADATA
# title: "Guarantee proper configuration of a security setup for AWS EMR clusters"
# description: "Enhance security protocols by enforcing the setup of a dedicated security configuration within AWS EMR clusters, bolstering data protection and access control measures."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emr_cluster
# custom:
#   id: CB_TFAWS_365
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_365

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_emr_cluster"
}

has_attribute(key, value) if {
	value in object.keys(key)
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
	has_attribute(resource.Attributes, "security_configuration")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Security setup for AWS EMR clusters is properly configured.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Security setup for AWS EMR clusters must be properly configured.",
		"snippet": block,
	}
}
