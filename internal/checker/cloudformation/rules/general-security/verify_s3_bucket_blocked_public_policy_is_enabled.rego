# METADATA
# title: "Verify S3 bucket blocked public policy is enabled."
# description: "This policy applies at both the account and bucket levels, including future buckets. It blocks existing public access and prevents new items from being publicly accessible. For AWS accounts hosting data lakes or other business applications, it acts as a protective measure against accidental public exposure."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   id: CB_CFT_036
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_036
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
	block.BlockPublicPolicy == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "S3 bucket have blocked public policy",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "S3 bucket should block public policy .",
		"snippet": block,
	}
}
