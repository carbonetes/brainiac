# METADATA
# title: "Verify that an S3 bucket has a lifecycle configuration"
# description: "By configuring a lifecycle policy for an S3 bucket, you can automatically transition objects to different storage classes or delete them when they're no longer needed."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration
# custom:
#   id: CB_TFAWS_362
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_362

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_s3_bucket"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

gets3bucketlabel contains label if {
	some resource in input
	resource.Type == "resource"
	"aws_s3_bucket" in resource.Labels
	label := concat(".", resource.Labels)
}

is_valid_resource_attached if {
	some resource in input
	resource.Type == "resource"
	"aws_s3_bucket_lifecycle_configuration" in resource.Labels
	some label in gets3bucketlabel
	contains(resource.Attributes.bucket, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	resource.Blocks[_].Type == "lifecycle_rule"
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "S3 bucket has a lifecycle configuration.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "S3 bucket should have a lifecycle configuration.",
		"snippet": block,
	}
}
