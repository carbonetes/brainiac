# METADATA
# title: "Verify all data stored in the S3 bucket is securely encrypted at rest"
# description: "Encryption helps to protect sensitive information from unauthorized access or theft and prevents data from being compromised in case of a security breach or accidental exposure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
# custom:
#   id: CB_TFAWS_024
#   severity: LOW
package lib.terraform.CB_TFAWS_024

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_s3_bucket", "aws_s3_bucket_server_side_encryption_configuration"]
	label in supportedresource
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

aesimplemented(block) if {
	some ruleblock in block.Blocks
	ruleblock.Type == "rule"
	some encryptionblock in ruleblock.Blocks
	encryptionblock.Type == "apply_server_side_encryption_by_default"
	encryptionblock.Attributes.sse_algorithm == "AES256"
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "server_side_encryption_configuration"
	aesimplemented(block)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	aesimplemented(resource)
}

fail contains block if {
	some block in input
	isvalid(block)
	passcount := pass
	count(passcount) == 0
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_s3_bucket' 'logging' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_s3_bucket' 'logging' should be set",
		"snippet": block,
	}
}
