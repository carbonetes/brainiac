# METADATA
# title: "Verify S3 lifecycle configuration sets period for aborting failed uploads"
# description: "Verifying the S3 lifecycle configuration to set a period for aborting failed uploads ensures cost optimization, resource management, performance improvement, data integrity, security compliance, and automation benefits in your AWS S3 storage infrastructure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.1.0/docs/data-sources/s3_bucket
# custom:
#   id: CB_TFAWS_275
#   severity: LOW
package lib.terraform.CB_TFAWS_275

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_s3_bucket_lifecycle_configuration"
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
	some block in resource.Blocks
	block.Type == "rule"
	block.Blocks[_].Type == "abort_incomplete_multipart_upload"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "S3 lifecycle configuration sets period for aborting failed uploads",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "S3 lifecycle configuration must set period for aborting failed uploads",
		"snippet": block,
	}
}
