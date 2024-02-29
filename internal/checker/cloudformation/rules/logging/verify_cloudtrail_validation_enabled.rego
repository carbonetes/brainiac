# METADATA
# title: "Verify CloudTrail log validation are enabled"
# description: "AWS CloudTrail documents AWS API calls, accessible per IAM policies. AWS KMS manages encryption keys with HSMs. CloudTrail logs use SSE and KMS CMKs for security. Configure CloudTrail with SSE-KMS for added confidentiality. Users need S3 read permission and CMK decryption rights for log access."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cloudtrail-trail.html
# custom:
#   id: CB_CFT_30
#   severity: LOW
package lib.cloudformation.CB_CFT_30
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

