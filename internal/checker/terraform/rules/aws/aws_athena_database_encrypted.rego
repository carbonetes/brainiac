# METADATA
# title: "A secure Athena Database should be encrypted at all times (the default is not encrypted)."
# description: "In order to further safeguard your data from illegal access to the underlying Amazon S3 storage, the encryption at rest capability made available for AWS Athena query results is available."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
# custom:
#   id: CB_TFAWS_059
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_059

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_athena_database"
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
	some encryption_configuration in resource.Blocks
	encryption_configuration.Type == "encryption_configuration"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "aws_athena_database encryption is encrypted.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "aws_athena_database encryption should be encrypted.",
		"snippet": block,
	}
}

