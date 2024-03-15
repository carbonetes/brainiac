# METADATA
# title: "Verify S3 bucket restrict write access"
# description: "This policy emphasizes restricting WRITE access to AWS S3 buckets to prevent data breaches and unauthorized manipulation. Only buckets designated for static website hosting should be globally accessible. Utilizing Bucket ACLs helps manage access effectively."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   id: CB_CFT_039
#   severity: High
package lib.cloudformation.CB_CFT_039

import future.keywords.in

resource := "AWS::S3::Bucket"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[resources] {
	some resources in input.Resources
	is_valid
	count(fail) == 0
}

fail[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties
	block.AccessControl == "PublicReadWrite"
}

passed[result] {
	some block in pass
	result := {
		"message": "S3 bucket Write access is private",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "S3 bucket Write access should be private.",
		"snippet": block,
	}
}
