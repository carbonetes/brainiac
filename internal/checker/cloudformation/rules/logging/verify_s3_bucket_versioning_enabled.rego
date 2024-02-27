# METADATA
# title: "Verify S3 Bucket Versioning is enabled"
# description: "Checks if versioning is enabled on AWS S3 buckets"
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html
# custom:
#   id: CB_CFT_011
#   severity: HIGH
package lib.cloudformation.CB_CFT_011

import future.keywords.in

resource := "AWS::S3::Bucket"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties.VersioningConfiguration
	block.Status == "Enabled"
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "S3 bucket have versioning enabled.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "S3 bucket does not have versioning enabled.",
		"snippet": block,
	}
}
