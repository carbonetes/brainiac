# METADATA
# title: "A customer managed Key (CMK) should be used to encrypt the Neptune snapshot"
# description: "This allows you to have greater control over the encryption process, adding an extra layer of security to your sensitive data."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/neptune_cluster_snapshot.html
# custom:
#   id: CB_TFAWS_262
#   severity: HIGH
package lib.terraform.CB_TFAWS_262

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
	has_attribute(resource.Attributes, "kms_key_id")
	resource.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "Customer Managed Key (CMK) is used to encrypt the fx ontap file system.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "Customer Managed Key (CMK) must be used to encrypt the fx ontap file system.",
		"snippet": block,
	}
}
