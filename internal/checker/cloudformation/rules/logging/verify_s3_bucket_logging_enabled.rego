# METADATA
# title: "Verify S3 bucket access logging is enabled"
# description: "This policy ensures thorough auditing for all files and directories stored within an S3 bucket."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-s3-bucket.html
# custom:
#   id: CB_CFT_009
#   severity: LOW
package lib.cloudformation.CB_CFT_009
import future.keywords.in

resource := "AWS::S3::Bucket"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[resources] {
    is_valid
    some resources in input.Resources
    logging_config := resources.Properties.LoggingConfiguration
    logging_config != null
    logging_config != {}
    logging_config.DestinationBucketName != null
}


fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Access logging is successfully configured to provide detailed audit logs for the S3 bucket.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Access logging must be configured to provide detailed audit logs for the S3 bucket.",
		"snippet": block,
	}
}
