# METADATA
# title: "Verify RDS Cluster activity streams are encrypted using KMS CMKs."
# description: "By enabling KMS key for RDS encryption, the Terraform configuration ensures that the RDS cluster stays up-to-date with the latest enhancements and security patches, maintaining data integrity and minimizing vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_activity_stream
# custom:
#   id: CB_TFAWS_276
#   severity: LOW
package lib.terraform.CB_TFAWS_276

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_rds_cluster_activity_stream"
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
		"message": "RDS Cluster activity streams are encrypted using KMS CMKs.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "RDS Cluster activity streams is not encrypted using KMS CMKs.",
		"snippet": block,
	}
}
