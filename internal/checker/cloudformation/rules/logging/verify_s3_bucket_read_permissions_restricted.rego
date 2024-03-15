# METADATA
# title: "Verify S3 Bucket Restricts READ Permissions from Everyone"
# description: "This policy verifies that the specified S3 bucket is configured to restrict READ permissions from everyone. By enforcing this restriction, the policy aims to mitigate the risk of unauthorized access to sensitive data stored within the bucket."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   id: CB_CFT_011
#   severity: CRITICAL
package lib.cloudformation.CB_CFT_011
import future.keywords.in

resource := "AWS::S3::Bucket"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[read_permissions] {
	is_valid
	some resources in input.Resources
	read_permissions := resources.Properties
	forbidden_values := ["PublicReadWrite", "PublicRead"]
	not read_permissions.AccessControl in forbidden_values
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "The S3 bucket successfully restricts READ permissions from everyone.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The S3 bucket does not restrict READ permissions from everyone.",
		"snippet": block,
	}
}
