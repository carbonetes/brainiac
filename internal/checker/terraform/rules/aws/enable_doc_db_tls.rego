# METADATA
# title: "Verify that DocDB TLS is not disabled"
# description: "By ensuring that DocDB TLS is not disabled, you enhance the security and protection of sensitive data transmitted between client applications and the Amazon DocumentDB cluster, guarding against potential unauthorized access and data breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster_parameter_group#parameter
# custom:
#   id: CB_TFAWS_097
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_097

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_docdb_cluster_parameter_group"
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

pass contains block if {
	some block in input
	isvalid(block)
	not fail[block]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	some blocks in resource.Blocks
	blocks.Type == "parameter"
	has_attribute(blocks.Attributes, "name")
	blocks.Attributes.name == "tls"
	has_attribute(blocks.Attributes, "value")
	blocks.Attributes.value == "disabled"
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_docdb_cluster_parameter_group' for 'parameter' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_docdb_cluster_parameter_group' for 'parameter' should be set.",
		"snippet": block,
	}
}