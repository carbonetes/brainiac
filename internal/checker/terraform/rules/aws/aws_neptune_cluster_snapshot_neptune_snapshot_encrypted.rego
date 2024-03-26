# METADATA
# title: "Verify that the encryption of Neptune snapshots is robust and secure"
# description: "Enforce robust encryption measures for Neptune snapshots to safeguard sensitive data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster_snapshot.html
# custom:
#   id: CB_TFAWS_261
#   severity: HIGH
package lib.terraform.CB_TFAWS_261

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_neptune_cluster_snapshot"
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
		"message": "Neptune snapshots is encrypted in a way that meets security standards.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Neptune snapshots must be encrypted in a way that meets security standards.",
		"snippet": block,
	}
}
