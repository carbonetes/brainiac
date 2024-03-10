# METADATA
# title: "Verify S3 bucket enabled RestrictPublicBuckets"
# description: "Verify the activation of RestrictPublicBuckets for an S3 bucket to enhance security measures."
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   id: CB_CFT_43
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_43
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
	block := resources.Properties.PublicAccessBlockConfiguration
	block.RestrictPublicBuckets == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "S3 bucket have restricted public buckets.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "S3 bucket should restrict public buckets.",
		"snippet": block,
	}
}
