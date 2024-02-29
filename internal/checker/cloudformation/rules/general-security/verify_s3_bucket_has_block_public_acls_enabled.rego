# METADATA
# title: "Verify S3 bucket blocked Public ACLs is enabled."
# description: "This policy ensures that the S3 bucket is configured with the Block Public ACLs setting enabled to prevent public access control list modifications."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   ID: CB_CFT_40
#   Severity: Medium

package lib.cloudformation.CB_CFT_40

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
	block.BlockPublicAcls == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "S3 bucket have blocked public ACL's",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "S3 bucket should block public ACL's .",
		"snippet": block,
	}
}
