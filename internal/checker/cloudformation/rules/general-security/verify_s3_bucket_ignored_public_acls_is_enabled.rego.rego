# METADATA
# title: "Verify S3 bucket ignored public ACLs is enabled"
# description: "Confirm that an AWS S3 bucket restricts public write permissions to bolster security measures."
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   ID: CB_CFT_42
#   Severity: Medium
package lib.cloudformation.CB_CFT_42
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
	block.IgnorePublicAcls == true
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "S3 bucket have igonored public ACL's.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "S3 bucket should ignored public ACL's.",
		"snippet": block,
	}
}
