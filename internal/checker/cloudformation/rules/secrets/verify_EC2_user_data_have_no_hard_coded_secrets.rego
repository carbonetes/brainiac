# METADATA
# title: "Verify EC2 User Data have no hard coded secrets."
# description: "Implement and automate verification processes to ensure EC2 user data does not contain hard-coded secrets, enhancing the security posture of AWS environments."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-instance.html
# custom:
#   id: CB_CFT_032
#   severity: HIGH
package lib.cloudformation.CB_CFT_032

import future.keywords.in

resource := "AWS::EC2::Instance"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[resources] {
	is_valid
	resources := input.Resources
	count(fail) == 0
}

fail[user_data] {
	is_valid
	some resources in input.Resources
	some user_data in resources.Properties.UserData
	regex_pattern = `^arn:aws:secretsmanager:[a-z0-9-]+:[0-9]+:secret:[a-zA-Z0-9-_]+$`
	regex.match(regex_pattern, user_data)
}

passed[result] {
	some resources in pass
	result := {
		"message": "No hard coded secrets in EC2 User Data.",
		"snippet": resources,
	}
}

failed[result] {
	some resources in fail
	result := {
		"message": "Hard coded secrets found in EC2 User Data.",
		"snippet": resources,
	}
}
