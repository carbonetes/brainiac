# METADATA
# title: "Verify Glue Security Configuration encryption is enabled"
# description: "This policy ensures encryption is enabled for AWS Glue across its three components: CloudWatch, job bookmarks, and S3 buckets."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-glue-securityconfiguration.html
# custom:
#   id: CB_CFT_073
#   severity: HIGH
package lib.cloudformation.CB_CFT_073
import future.keywords.in

resource := "AWS::Glue::SecurityConfiguration"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

fail[properties] {
    is_valid
    some resources in input.Resources
    properties := resources.Properties
	encryption := properties.EncryptionConfiguration
    encryption.CloudWatchEncryption.CloudWatchEncryptionMode == "DISABLED"
    encryption.JobBookmarksEncryption.JobBookmarksEncryptionMode == "DISABLED"
    encryption.S3Encryption.S3EncryptionMode == "DISABLED"
}

pass[resources] {
    resources := input.Resources
    is_valid
    count(fail) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Glue Security Configuration Encryption is enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Glue Security Configuration Encryption is not enabled",
		"snippet": block,
	}
}
