# METADATA
# title: "Verify S3 bucket enabled RestrictPublicBuckets"
# description: "This policy in S3 Block Public Access lets you control whether public bucket policies are restricted for buckets in your account. When RestrictPublicBucket is set to TRUE, access to buckets with public policies is limited to AWS services and authorized users within the account. Enabling this setting doesn't affect existing bucket policies but blocks any public or cross-account access specified in them."
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   id: CB_CFT_038
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_038
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
