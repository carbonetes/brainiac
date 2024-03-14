# METADATA
# title: "Verify validation for Cloudtrail log are enabled"
# description: "This policy to ensure CloudTrail log file validation is implemented, generating digitally signed digest files containing hashes for each log written to S3 by CloudTrail. These files help detect any changes, deletions, or unchanged states of log files after delivery by CloudTrail. Enabling file validation for all CloudTrails is recommended to bolster integrity checks for CloudTrail logs."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudtrail-trail.html
# custom:
#   id: CB_CFT_026
#   severity: LOW
package lib.cloudformation.CB_CFT_026
import future.keywords.in

resource := "AWS::CloudTrail::Trail"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
	is_valid
	some resources in input.Resources
	properties := resources.Properties
	protocol := properties.EnableLogFileValidation
	protocol == true
}

fail[resources] {
	resources := input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Log file validation is enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Log file validation should be enable",
		"snippet": block,
	}
}

