# METADATA
# title: "Verify that Redshift cluster should not be publicly accessible"
# description: "By keeping the Redshift cluster not publicly accessible enhances security by limiting access to authorized users and preventing potential unauthorized access or attacks from the internet."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster#publicly_accessible
# custom:
#   id: CB_TFAWS_094
#   severity: LOW
package lib.terraform.CB_TFAWS_094

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_redshift_cluster"
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
	has_attribute(resource.Attributes, "publicly_accessible")
	resource.Attributes.publicly_accessible == false
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_redshift_cluster' for 'publicly_accessible' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_redshift_cluster' for 'publicly_accessible' should be set.",
		"snippet": block,
	}
}