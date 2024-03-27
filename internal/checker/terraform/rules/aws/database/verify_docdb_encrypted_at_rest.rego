# METADATA
# title: "Verify DocDB is encrypted at rest (default is unencrypted)"
# description: "Enabling encryption at rest for Amazon DocumentDB (DocDB) provides an added layer of security for your data. By default, DocDB does not encrypt data at rest, which can pose a risk if sensitive or confidential information is stored in the database."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_cluster
# custom:
#   id: CB_TFAWS_083
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_083

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_docdb_cluster"
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
	resource.Attributes.storage_encrypted == true
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_docdb_cluster' 'storage_encrypted' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_docdb_cluster' 'storage_encrypted' should be set to true.",
		"snippet": block,
	}
}