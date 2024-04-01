# METADATA
# title: "Verify S3 buckets should have event notifications enabled"
# description: "Enabling event notifications enhances operational visibility, automation, and integration capabilities, as it allows various AWS services and external systems to respond to changes in the S3 bucket in real-time."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification
# custom:
#   id: CB_TFAWS_363
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_363

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
	"aws_s3_bucket_notification" in resource.Labels
	some label in gets3bucketlabel
	contains(resource.Attributes.bucket, label)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	is_valid_resource_attached
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "S3 buckets has a event notifications enabled.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "S3 buckets should have event notifications enabled.",
		"snippet": block,
	}
}
