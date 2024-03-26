# METADATA
# title: "Verify that all NACL are connected to subnets"
# description: "Since this enables you to provide particular rules for regulating inbound and outbound traffic for those subnets, it is crucial to make it a priority that all NACLs are connected to subnets."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl.html
# custom:
#   id: CB_TFAWS_320
#   severity: LOW
package lib.terraform.CB_TFAWS_320

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_network_acl"
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

isawsvpcexist if {
	some resource in input
	resource.Type == "resource"
	some label in resource.Labels
	label == "aws_vpc"
}

isawssubnetexist if {
	some resource in input
	resource.Type == "resource"
	some label in resource.Labels
	label == "aws_subnet"
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	isawsvpcexist
	isawssubnetexist
	has_attribute(resource.Attributes, "subnet_ids")
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	isawssubnetexist
	has_attribute(resource.Attributes, "subnet_ids")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "All NACL are connected to subnets.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "All NACL must be connected to subnets.",
		"snippet": block,
	}
}
