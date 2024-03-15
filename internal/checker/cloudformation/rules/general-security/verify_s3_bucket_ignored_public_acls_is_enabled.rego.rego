# METADATA
# title: "Verify S3 bucket ignored public ACLs is enabled"
# description: "This policy disregards all public ACLs on a bucket and its objects in S3. It doesn't affect existing ACLs or prevent new public ACLs. While it blocks public access granted by ACLs, it still allows PUT Object calls with a public ACL."
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   id: CB_CFT_037
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_037
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
