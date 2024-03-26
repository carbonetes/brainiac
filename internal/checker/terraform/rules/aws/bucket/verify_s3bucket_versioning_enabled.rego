# METADATA
# title: "Make sure that the S3 bucket has versioning enabled for all data stored in it."
# description: "Enabling versioning for an S3 bucket ensures that every object stored in the bucket is assigned a unique version ID, allowing you to preserve, retrieve, and restore previous versions of the object. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning
# custom:
#   id: CB_TFAWS_038
#   severity: HIGH
package lib.terraform.CB_TFAWS_038

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supportedresource := ["aws_s3_bucket", "aws_s3_bucket_versioning"]
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

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "versioning"
	block.Attributes.enabled == true
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "versioning_configuration"
	block.Attributes.status == "Enabled"
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
		"message": "'aws_s3_bucket_versioning' is set properly.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "'aws_s3_bucket_versioning' should be enabled",
		"snippet": block,
	}
}
