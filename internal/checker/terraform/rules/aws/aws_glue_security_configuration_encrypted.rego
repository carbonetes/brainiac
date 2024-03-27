# METADATA
# title: "Make certain that Glue Security Configuration Encryption is activated"
# description: "Three AWS glue components, including Cloudwatch, job bookmarks, and S3 buckets, have the potential to be encrypted. This check guarantees that each is properly set."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/4.8.0/docs/resources/glue_security_configuration
# custom:
#   id: CB_TFAWS_107
#   severity: HIGH
package lib.terraform.CB_TFAWS_107

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_glue_security_configuration"
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
	some encryptionconfig in block.Blocks
	encryptionconfig.Type == "encryption_configuration"
	some c
	encryptionconfig.Blocks[c].Type == "cloudwatch_encryption"
	some j
	encryptionconfig.Blocks[j].Type == "job_bookmarks_encryption"
	some s
	encryptionconfig.Blocks[s].Type == "s3_encryption"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "'aws_glue_security_configuration' is encrypted.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_glue_security_configuration' should be encrypted.",
		"snippet": block,
	}
}