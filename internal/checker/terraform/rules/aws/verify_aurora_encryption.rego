# METADATA
# title: "Verify that all data stored in Aurora is securely encrypted at rest"
# description: "By enabling storage encryption in Aurora, sensitive data is protected against unauthorized access, ensuring the confidentiality and integrity of the stored information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance.html#storage_encrypted
# custom:
#   id: CB_TFAWS_110
#   severity: HIGH
package lib.terraform.CB_TFAWS_110

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_rds_cluster"
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
	resource.Attributes.engine_mode == "serverless"
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	not resource.Attributes.engine_mode == "serverless"
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
		"message": "'aws_rds_cluster' for 'storage_encrypted' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_rds_cluster' for 'storage_encrypted' should be set.",
		"snippet": block,
	}
}