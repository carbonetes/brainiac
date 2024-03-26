# METADATA
# title: "Verify every security groups rule has a description"
# description: "This can help in auditing and compliance efforts, as well as making it easier for administrators to understand and manage the security group configuration."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group.html
# custom:
#   id: CB_TFAWS_043
#   severity: LOW
package lib.terraform.CB_TFAWS_043

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := [
		"aws_db_security_group",
		"aws_elasticache_security_group",
		"aws_redshift_security_group",
		"aws_security_group",
		"aws_security_group_rule",
		"aws_vpc_security_group_egress_rule",
		"aws_vpc_security_group_ingress_rule",
	]
	label in supportedresource
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
	has_attribute(resource.Attributes, "description")
}

fail contains block if {
	some block in pass
	some childblock in block.Blocks
	validgroups := ["ingress", "egress"]
	childblock.Type in validgroups
	not has_attribute(childblock.Attributes, "description")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "security groups rule has a description.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "security groups rule should have a description.",
		"snippet": block,
	}
}