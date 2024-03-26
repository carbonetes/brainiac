# METADATA
# title: "Verify the S3 bucket has access logging enabled"
# description: "Enabling access logging for an S3 bucket provides visibility into who is accessing the data and when."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging
# custom:
#   id: CB_TFAWS_023
#   severity: LOW
package lib.terraform.CB_TFAWS_023

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_s3_bucket"
}

isS3Logging(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_s3_bucket_logging"
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
    block.Type == "logging"
}

pass contains resource if{
    some resource in input
	isS3Logging(resource)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := { "message": "'aws_s3_bucket' 'logging' is set properly.",
                "snippet": block }
}

failed contains result if {
	some block in fail
	result := { "message": "'aws_s3_bucket' 'logging' should be set",
                "snippet": block }
} 