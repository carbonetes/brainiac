# METADATA
# title: "Verify all data stored in the RDS is securely encrypted at rest"
# description: "Encryption of data at rest helps to prevent data breaches and protect the confidentiality, integrity, and availability of data in the RDS."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#storage_encrypted
# custom:
#   id: CB_TFAWS_019
#   severity: HIGH
package lib.terraform.CB_TFAWS_019

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_db_instance"
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
	result := { "message": "'aws_db_instance' 'storage_encrypted' is set properly.",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_db_instance' 'storage_encrypted' should be set to true",
                "snippet": block }
} 