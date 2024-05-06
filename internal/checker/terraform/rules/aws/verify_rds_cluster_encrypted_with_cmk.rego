# METADATA
# title: "Verify RDS Clusters are encrypted using KMS CMKs"
# description: "This policy is designed to ensure that all Amazon RDS clusters within the organization are encrypted using Key Management Service (KMS) Customer Master Keys (CMKs)."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance.html#kms_key_id
# custom:
#   id: CB_TFAWS_299
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_299

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

pass contains block if {
	some block in input
	isvalid(block)
	block.Attributes.kms_key_id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "RDS Clusters are encrypted using KMS CMKs.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "RDS Clusters must be encrypted using KMS CMKs.",
		"snippet": block,
	}
}
