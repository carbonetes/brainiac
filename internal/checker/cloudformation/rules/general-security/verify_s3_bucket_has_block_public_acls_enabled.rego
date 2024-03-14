# METADATA
# title: "Verify S3 bucket blocked Public ACLs is enabled."
# description: "This policy ensures that Amazon S3 buckets and objects are initially set to private. It prevents the creation of new public ACLs, thereby blocking future attempts to grant public access. Setting the S3 Bucket BlockPublicAcls to True is recommended for security."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   id: CB_CFT_035
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_035
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
