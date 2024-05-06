# METADATA
# title: "Verify that EMR clusters with Kerberos have Kerberos Realm set"
# description: "By enforcing the requirement for the Kerberos Realm to be set, unauthorized access is mitigated, and only authenticated and authorized users can access the cluster resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emr_cluster
# custom:
#   id: CB_TFAWS_103
#   severity: LOW
package lib.terraform.CB_TFAWS_103

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

has_attribute(key, value) if {
	value in object.keys(key)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some blocks in resource.Blocks
	blocks.Type == "kerberos_attributes"
	has_attribute(blocks.Attributes, "realm")
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_emr_cluster' 'kerberos_attributes' realm is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_emr_cluster' 'kerberos_attributes' realm should be set.",
		"snippet": block,
	}
}