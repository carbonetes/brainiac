# METADATA
# title: "Verify that the DocDB Global Cluster enforces encryption at rest, as the default state is unencrypted"
# description: "This checks whether encryption at rest is enabled for the DocDB Global Cluster. It ensures that data in the cluster is securely encrypted, providing an additional layer of protection for sensitive information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/docdb_global_cluster
# custom:
#   id: CB_TFAWS_269
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_269

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_docdb_global_cluster"
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
	has_attribute(resource.Attributes, "storage_encrypted")
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
		"message": "Encryption at rest is activated for the DocDB Global Cluster.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Encryption at rest must be activated for the DocDB Global Cluster.",
		"snippet": block,
	}
}
