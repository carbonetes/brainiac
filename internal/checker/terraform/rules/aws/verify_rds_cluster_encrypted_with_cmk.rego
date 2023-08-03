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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_rds_cluster"
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.kms_key_id != ""
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "RDS Clusters are encrypted using KMS CMKs.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "RDS Clusters must be encrypted using KMS CMKs.",
		"snippet": block,
	}
}
