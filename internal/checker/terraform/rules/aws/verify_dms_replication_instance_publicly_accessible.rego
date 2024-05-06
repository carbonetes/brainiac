# METADATA
# title: "Verify that DMS replication instance should not be publicly accessible"
# description: "By not allowing public accessibility to the DMS replication instance, the security and integrity of the database are safeguarded from unauthorized access or potential security breaches."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance#publicly_accessible
# custom:
#   id: CB_TFAWS_096
#   severity: HIGH
package lib.terraform.CB_TFAWS_096

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_dms_replication_instance"
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
	has_attribute(resource.Attributes, "publicly_accessible")
	resource.Attributes.publicly_accessible == true
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_dms_replication_instance' for 'publicly_accessible' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_dms_replication_instance' for 'publicly_accessible' should be set.",
		"snippet": block,
	}
}