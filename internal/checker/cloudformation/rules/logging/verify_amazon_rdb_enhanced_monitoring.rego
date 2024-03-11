# METADATA
# title: "Verify enhanced monitoring is enabled for Amazon RDS instances"
# description: "Checks if the Amazon RDS instances enabled enhanced monitoring."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbinstance.html
# custom:
#   id: CB_CFT_092
#   severity: LOW
package lib.cloudformation.CB_CFT_092

import future.keywords.in

resource := "AWS::RDS::DBInstance"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[block] {
	is_valid
	some resources in input.Resources
	resources.Type == resource
	block := resources.Properties
	values := [1, 5, 10, 15, 30, 60, "1", "5", "10", "15", "30", "60"]
	block.MonitoringInterval in values
}

fail[resources] {
	some resources in input.Resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "Enhanced monitoring is enabled for the Amazon RDS instance.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Enhanced monitoring is not enabled for the Amazon RDS instance.",
		"snippet": block,
	}
}
